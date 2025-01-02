import Foundation

// MARK: - APISessionContract Protocol

/// Protocolo que define las operaciones necesarias para realizar solicitudes a la API.
///
/// Proporciona un método para enviar una solicitud de tipo `APIRequest` y manejar la respuesta.
protocol APISessionContract {
    
    /**
     Realiza una solicitud a la API.

     - Parameter apiRequest: Un objeto que conforma el protocolo `APIRequest`, que describe la solicitud a realizar.
     - Parameter completion: Un cierre que maneja el resultado de la solicitud, que puede ser un `Data` o un `Error`.
     */
    func request<Request: APIRequest>(apiRequest: Request, completion: @escaping (Result<Data, Error>) -> Void)
}

// MARK: - APISession Structure

/// Estructura que conforma el protocolo `APISessionContract` y gestiona las solicitudes de API.
///
/// Utiliza `URLSession` para realizar las solicitudes de red y aplica interceptores de solicitud.
struct APISession: APISessionContract {
    
    // MARK: - Properties
    
    /// Instancia compartida de `APISession`, que se utiliza como singleton.
    static var shared: APISessionContract = APISession()
    
    /// Instancia de `URLSession` utilizada para realizar las solicitudes.
    private let session = URLSession(configuration: .default)
    
    /// Lista de interceptores de solicitud que pueden modificar la solicitud antes de enviarla.
    private let requestInterceptors: [APIRequestInterceptor]
    
    // MARK: - Initializers
    
    /**
     Inicializa una nueva instancia de `APISession`.

     - Parameter requestInterceptors: Un arreglo de interceptores de solicitud. Se inicializa con un interceptor de autenticación por defecto.
     */
    init(requestInterceptors: [APIRequestInterceptor] = [AuthenticationRequestInterceptor()]) {
        self.requestInterceptors = requestInterceptors
    }
    
    // MARK: - APISessionContract Methods
    
    func request<Request: APIRequest>(apiRequest: Request, completion: @escaping (Result<Data, Error>) -> Void) {
        do {
            // Obtiene la solicitud configurada desde el `apiRequest`
            var request = try apiRequest.getRequest()
            
            // Aplica los interceptores a la solicitud
            requestInterceptors.forEach { $0.intercept(request: &request) }
            
            // Realiza la solicitud a la API
            session.dataTask(with: request) { data, response, error in
                if let error {
                    // Si hay un error, lo devuelve
                    return completion(.failure(error))
                }
                
                // Verifica que la respuesta sea un `HTTPURLResponse` y el código de estado sea 200
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    return completion(.failure(APIErrorResponse.network(apiRequest.path)))
                }
                
                // Devuelve los datos recibidos o un objeto `Data` vacío
                return completion(.success(data ?? Data()))
            }.resume()
        } catch {
            // Maneja errores en la creación de la solicitud
            completion(.failure(error))
        }
    }
}
