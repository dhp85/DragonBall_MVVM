import Foundation


// MARK: - Protocols

/// Protocolo que define el contrato para el caso de uso de obtener todos los héroes.
protocol GetAllHeroesUseCaseContract {
    /**
     Ejecuta el proceso para obtener una lista de todos los héroes.
     
     - Parameter completion: Closure que se ejecuta al completar la operación. Retorna un `Result` que puede ser `.success` con un arreglo de `Hero` si la operación fue exitosa o `.failure` con un `Error` si ocurrió un error.
     */
    func execute(completion: @escaping (Result<[Hero], Error>) -> Void)
}

// MARK: - Classes

/// Caso de uso responsable de obtener una lista de todos los héroes.
final class GetAllHeroesUseCase: GetAllHeroesUseCaseContract {
    
    // MARK: - Initializers
    
    /**
     Inicializa una nueva instancia de `GetAllHeroesUseCase`.
     
     - Note: Actualmente no requiere inyección de dependencias, pero está preparado para ello si se necesita en el futuro.
     */
    init() {
        // Inicialización si se requieren dependencias adicionales en el futuro.
    }
    
    // MARK: - Public Methods
    
    /**
     Ejecuta el proceso para obtener una lista de todos los héroes.
     
     - Parameter completion: Closure que se ejecuta al completar la operación. Retorna un `Result` que puede ser `.success` con un arreglo de `Hero` si la operación fue exitosa o `.failure` con un `Error` si ocurrió un error.
     
     - Note: Realiza una solicitud a través de `GetHeroesAPIRequest` y maneja el resultado, devolviendo los héroes obtenidos o un error en caso de fallo.
     */
    func execute(completion: @escaping (Result<[Hero], Error>) -> Void) {
        // Realiza la solicitud de obtener héroes con un nombre vacío para obtener todos.
        GetHeroesAPIRequest(name: "")
            .perform { result in
                do {
                    // Intenta obtener el resultado exitoso y lo pasa al completion.
                    try completion(.success(result.get()))
                } catch {
                    // En caso de error, pasa el error al completion.
                    completion(.failure(error))
                }
            }
    }
}
