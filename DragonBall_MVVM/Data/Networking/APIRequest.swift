import Foundation

enum HTTPMethod: String {
    case GET, POST, PUT, UPDATE, HEAD, PATCH, DELETE, OPTIONS
}

// MARK: - APIRequest Protocol

/// Protocolo que define las propiedades y métodos necesarios para realizar una solicitud a la API.
///
/// Este protocolo proporciona las configuraciones básicas para construir una solicitud HTTP, incluyendo
/// el método, la URL, los encabezados y el cuerpo de la solicitud.
protocol APIRequest {
    
    // MARK: - Properties
    
    /// El host de la API.
    var host: String { get }
    
    /// El método HTTP que se utilizará en la solicitud (GET, POST, etc.).
    var method: HTTPMethod { get }
    
    /// Un objeto que conforma `Encodable`, que representa el cuerpo de la solicitud.
    var body: Encodable? { get }
    
    /// La ruta específica del recurso que se va a solicitar.
    var path: String { get }
    
    /// Un diccionario de encabezados que se incluirán en la solicitud.
    var headers: [String: String] { get }
    
    /// Un diccionario de parámetros de consulta que se agregarán a la URL.
    var queryParameters: [String: String] { get }
    
    // MARK: - Associated Types
    
    /// El tipo de respuesta esperada de la solicitud, debe conformar el protocolo `Decodable`.
    associatedtype Response: Decodable
    
    /// Tipo que representa el resultado de la solicitud de API.
    typealias APIRequestResponse = Result<Response, APIErrorResponse>
    
    /// Tipo de cierre que se utiliza para manejar la respuesta de la solicitud.
    typealias APIRequestCompletion = (APIRequestResponse) -> Void
}

// MARK: - Default Implementation

extension APIRequest {
    
    // MARK: - Default Properties
    
    var host: String { "dragonball.keepcoding.education" }
    var queryParameters: [String: String] { [:] }
    var headers: [String: String] { [:] }
    var body: Encodable? { nil }
    
    /**
     Crea y configura un objeto `URLRequest` a partir de las propiedades del `APIRequest`.
     
     - Throws: `APIErrorResponse.malformedURL` si la URL generada es inválida.
     - Returns: Un objeto `URLRequest` configurado con los parámetros del `APIRequest`.
     */
    func getRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        
        // Agrega los parámetros de consulta si existen
        if !queryParameters.isEmpty {
            components.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        // Verifica que la URL sea válida
        guard let finalURL = components.url else {
            throw APIErrorResponse.malformedURL(path)
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        
        // Establece el cuerpo de la solicitud si no es un GET
        if method != .GET, let body {
            request.httpBody = try JSONEncoder().encode(body)
        }
        
        // Establece los encabezados de la solicitud
        request.allHTTPHeaderFields = ["Accept": "application/json", "Content-Type": "application/json"].merging(headers) { $1 }
        
        // Establece el tiempo de espera de la solicitud
        request.timeoutInterval = 10
        
        return request
    }
}

// MARK: - Execution

extension APIRequest {
    
    /**
     Ejecuta la solicitud utilizando una sesión de API y maneja la respuesta.
     
     - Parameter session: Una instancia que conforma el protocolo `APISessionContract`. Por defecto, se usa `APISession.shared`.
     - Parameter completion: Un cierre que maneja el resultado de la solicitud, que puede ser un `Response` o un `APIErrorResponse`.
     */
    func perform(session: APISessionContract = APISession.shared, completion: @escaping APIRequestCompletion) {
        session.request(apiRequest: self) { result in
            do {
                let data = try result.get()
                
                // Manejo de respuestas especiales
                if Response.self == Void.self {
                    return completion(.success(() as! Response))
                } else if Response.self == Data.self {
                    return completion(.success(data as! Response))
                }

                // Decodifica la respuesta a su tipo esperado
                return try completion(.success(JSONDecoder().decode(Response.self, from: data)))
            } catch let error as APIErrorResponse {
                // Maneja errores específicos de la API
                completion(.failure(error))
            } catch {
                // Maneja errores desconocidos
                completion(.failure(APIErrorResponse.unknown(path)))
            }
        }
    }
}
