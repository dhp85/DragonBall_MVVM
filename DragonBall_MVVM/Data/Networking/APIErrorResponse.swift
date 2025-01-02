import Foundation

// MARK: - APIErrorResponse Struct

/// Estructura que representa un error que ocurre durante la comunicación con la API.
///
/// Esta estructura conforma el protocolo `Error` y almacena información relevante sobre
/// un error que se ha producido al realizar una solicitud a la API, incluyendo la URL,
/// el código de estado, los datos asociados (si los hay) y un mensaje descriptivo.
struct APIErrorResponse: Error, Equatable {
    
    // MARK: - Properties
    
    /// La URL asociada con la solicitud que falló.
    let url: String
    
    /// El código de estado HTTP devuelto por la API.
    let statusCode: Int
    
    /// Los datos devueltos por la API en caso de un error (si los hay).
    let data: Data?
    
    /// Un mensaje descriptivo del error.
    let message: String
    
    // MARK: - Initializer
    
    /// Inicializa una nueva instancia de `APIErrorResponse`.
    ///
    /// - Parameters:
    ///   - url: La URL asociada con la solicitud que falló.
    ///   - statusCode: El código de estado HTTP devuelto por la API.
    ///   - data: Los datos devueltos por la API en caso de un error (opcional).
    ///   - message: Un mensaje descriptivo del error.
    init(url: String, statusCode: Int, data: Data? = nil, message: String) {
        self.url = url
        self.statusCode = statusCode
        self.data = data
        self.message = message
    }
}

// MARK: - APIErrorResponse Extension

/// Extensión de `APIErrorResponse` que proporciona métodos de inicialización para errores comunes.
extension APIErrorResponse {
    
    /// Crea una respuesta de error para un problema de red.
    ///
    /// - Parameter url: La URL asociada con la solicitud que falló.
    /// - Returns: Una nueva instancia de `APIErrorResponse` con un código de estado de -1.
    static func network(_ url: String) -> APIErrorResponse {
        APIErrorResponse(url: url, statusCode: -1, message: "Network error")
    }
    
    /// Crea una respuesta de error para problemas al parsear datos.
    ///
    /// - Parameter url: La URL asociada con la solicitud que falló.
    /// - Returns: Una nueva instancia de `APIErrorResponse` con un código de estado de -2.
    static func parseData(_ url: String) -> APIErrorResponse {
        APIErrorResponse(url: url, statusCode: -2, message: "Cannot Parse Data")
    }
    
    /// Crea una respuesta de error para un error desconocido.
    ///
    /// - Parameter url: La URL asociada con la solicitud que falló.
    /// - Returns: Una nueva instancia de `APIErrorResponse` con un código de estado de -3.
    static func unknown(_ url: String) -> APIErrorResponse {
        APIErrorResponse(url: url, statusCode: -3, message: "Unknown error")
    }
    
    /// Crea una respuesta de error para una colección vacía.
    ///
    /// - Parameter url: La URL asociada con la solicitud que falló.
    /// - Returns: Una nueva instancia de `APIErrorResponse` con un código de estado de -4.
    static func emptyCollection(_ url: String) -> APIErrorResponse {
        APIErrorResponse(url: url, statusCode: -4, message: "Empty response")
    }
    
    /// Crea una respuesta de error para una URL malformada.
    ///
    /// - Parameter url: La URL asociada con la solicitud que falló.
    /// - Returns: Una nueva instancia de `APIErrorResponse` con un código de estado de -5.
    static func malformedURL(_ url: String) -> APIErrorResponse {
        APIErrorResponse(url: url, statusCode: -5, message: "Can't create URL")
    }
}
