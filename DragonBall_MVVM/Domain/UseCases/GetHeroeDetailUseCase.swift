import Foundation

/// Protocolo que define el contrato para el caso de uso de obtener detalles de un héroe.
protocol GetHeroeDetailUseCaseContract {
    /**
     Ejecuta el caso de uso para obtener los detalles de un héroe específico.

     - Parameters:
        - heroe: El nombre del héroe cuyos detalles se desean obtener.
        - completion: Cierre que se ejecuta al finalizar la operación, retornando un `Result` que contiene un `Hero?` en caso de éxito o un `Error` en caso de fallo.
     */
    func execute(heroe: String, completion: @escaping (Result<Hero?, Error>) -> Void)
}

/// Clase que implementa el contrato para obtener detalles de un héroe.
/// Esta clase realiza una solicitud a la API para obtener los detalles del héroe especificado.
final class GetHeroeDetailUseCase: GetHeroeDetailUseCaseContract {
    
    /**
     Ejecuta el caso de uso para obtener los detalles de un héroe específico.
     
     - Parameters:
        - heroe: El nombre del héroe cuyos detalles se desean obtener.
        - completion: Cierre que se ejecuta al finalizar la operación, retornando un `Result` que contiene un `Hero?` en caso de éxito o un `Error` en caso de fallo.
     
     ## Descripción
     Esta implementación realiza una solicitud a la API utilizando `GetHeroesAPIRequest` para obtener una lista de héroes. Una vez que se obtiene la respuesta, busca el héroe cuyo nombre coincide (ignorando mayúsculas y minúsculas) con el proporcionado y retorna ese héroe en el resultado de éxito. Si ocurre un error durante la solicitud, este se propaga a través del resultado de fallo.
     */
    func execute(heroe: String, completion: @escaping (Result<Hero?, Error>) -> Void) {
        // Crea una solicitud a la API para obtener héroes que coincidan con el nombre proporcionado.
        GetHeroesAPIRequest(name: heroe)
            .perform { result in
                switch result {
                case .success(let heroes):
                    // Busca el primer héroe cuyo nombre coincide con el proporcionado, ignorando mayúsculas y minúsculas.
                    let hero = heroes.first { $0.name.lowercased() == heroe.lowercased() }
                    // Retorna el héroe encontrado en el resultado de éxito.
                    completion(.success(hero))
                case .failure(let error):
                    // Propaga el error ocurrido durante la solicitud.
                    completion(.failure(error))
                }
            }
    }
}
