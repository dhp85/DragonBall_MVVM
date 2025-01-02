

import Foundation

// MARK: - LoginAPIRequest Structure

/// Estructura que representa una solicitud de autenticación para iniciar sesión.
///
/// Conforma al protocolo `APIRequest`, definiendo cómo se configura la solicitud
/// HTTP necesaria para autenticar a un usuario con sus credenciales.
struct LoginAPIRequest: APIRequest {
    
    // MARK: - Typealias
    
    /// Tipo de respuesta esperada de la solicitud.
    typealias Response = Data
    
    // MARK: - Properties
    
    /// Encabezados HTTP para la solicitud, que incluye la información de autorización.
    let headers: [String: String]
    
    /// Método HTTP utilizado para la solicitud. En este caso, es POST.
    let method: HTTPMethod = .POST
    
    /// Ruta del endpoint al que se realizará la solicitud.
    let path: String = "/api/auth/login"
    
    // MARK: - Initializers
    
    /**
     Inicializa una nueva instancia de `LoginAPIRequest`.
     
     - Parameter credentials: Las credenciales del usuario, que incluyen el nombre de usuario y la contraseña.
     - Note: Se genera un encabezado de autorización utilizando codificación Base64 para las credenciales.
     */
    init(credentials: Credentials) {
        // Crea una representación de los datos de inicio de sesión.
        let logindata = Data(String(format: "%@:%@", credentials.username, credentials.password).utf8)
        
        // Codifica los datos en una cadena Base64.
        let base64String = logindata.base64EncodedString()
        
        // Configura los encabezados de autorización.
        headers = ["Authorization": "Basic \(base64String)"]
    }
}
