import Foundation

// MARK: - GetHeroesAPIRequest Structure

/// Estructura que representa una solicitud para obtener todos los héroes.
///
/// Conforma al protocolo `APIRequest`, definiendo cómo se configura la solicitud
/// HTTP necesaria para obtener información sobre los héroes.
struct GetHeroesAPIRequest: APIRequest {
    
    // MARK: - Typealias
    
    /// Tipo de respuesta esperada de la solicitud, que es un arreglo de `Hero`.
    typealias Response = [Hero]
    
    // MARK: - Properties
    
    /// Ruta del endpoint al que se realizará la solicitud para obtener todos los héroes.
    let path: String = "/api/heros/all"
    
    /// Método HTTP utilizado para la solicitud. En este caso, es POST.
    let method: HTTPMethod = .POST
    
    /// Cuerpo de la solicitud, que contiene información adicional para la misma.
    let body: (any Encodable)?
    
    // MARK: - Initializers
    
    /**
     Inicializa una nueva instancia de `GetHeroesAPIRequest`.
     
     - Parameter name: Nombre del héroe para filtrar la búsqueda. Si es nil, se establece una cadena vacía.
     - Note: Se crea un objeto `RequestEntity` que se codifica como el cuerpo de la solicitud.
     */
    init(name: String?) {
        body = RequestEntity(name: name ?? "")
    }
}

// MARK: - Private Extensions

private extension GetHeroesAPIRequest {
    
    // MARK: - RequestEntity Structure
    
    /// Estructura que representa el cuerpo de la solicitud para obtener héroes.
    ///
    /// Conforma al protocolo `Encodable`, permitiendo que esta estructura sea convertida
    /// a un formato adecuado para ser enviada en la solicitud HTTP.
    struct RequestEntity: Encodable {
        /// Nombre del héroe para filtrar la búsqueda.
        let name: String
    }
}
