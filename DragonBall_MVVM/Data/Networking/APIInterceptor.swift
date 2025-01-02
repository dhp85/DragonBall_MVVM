import Foundation

// MARK: - APIInterceptor Protocol

/// Protocolo base para interceptores de API.
///
/// Este protocolo puede ser utilizado como una interfaz para crear diversos interceptores de API,
/// permitiendo la modificación de solicitudes o respuestas.
protocol APIInterceptor { }

// MARK: - APIRequestInterceptor Protocol

/// Protocolo que define un interceptor específico para solicitudes API.
///
/// Este protocolo hereda de `APIInterceptor` y añade la funcionalidad de interceptar y modificar
/// las solicitudes antes de que sean enviadas.
protocol APIRequestInterceptor: APIInterceptor {
    
    /// Intercepta la solicitud y permite modificarla antes de ser enviada.
    ///
    /// - Parameter request: La solicitud que se va a interceptar. Este parámetro es inout,
    ///                     lo que permite modificar la solicitud directamente.
    func intercept(request: inout URLRequest)
}

// MARK: - AuthenticationRequestInterceptor Class

/// Interceptor de solicitudes que agrega un token de autorización a las solicitudes API.
///
/// Este interceptor se utiliza para incluir un token de sesión en los encabezados de autorización
/// de las solicitudes a la API.
final class AuthenticationRequestInterceptor: APIRequestInterceptor {
    
    // MARK: - Properties
    
    /// Fuente de datos que proporciona acceso a la sesión.
    private let dataSource: SessionDataSourceContract
    
    // MARK: - Initializer
    
    /// Inicializa un nuevo interceptor de autenticación.
    ///
    /// - Parameter dataSource: La fuente de datos para obtener la sesión. Por defecto, se utiliza `SessionDataSource()`.
    init(dataSource: SessionDataSourceContract = SessionDataSource()) {
        self.dataSource = dataSource
    }
    
    // MARK: - Interception
    
    /// Intercepta la solicitud y agrega el encabezado de autorización si hay una sesión válida.
    ///
    /// - Parameter request: La solicitud que se va a interceptar. Se modifica para incluir el
    ///                     token de autorización en los encabezados.
    func intercept(request: inout URLRequest) {
        // Verifica si hay una sesión activa
        guard let session = dataSource.getSession() else {
            return
        }
        
        // Establece el encabezado de autorización con el token de sesión
        request.setValue("Bearer \(String(decoding: session, as: UTF8.self))", forHTTPHeaderField: "Authorization")
    }
}
