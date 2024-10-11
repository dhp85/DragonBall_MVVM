import Foundation

protocol GetHeroeDetailUseCaseContract {
    func execute(heroe: String, completion: @escaping (Result<Hero?, Error>) -> Void)
}

final class GetHeroeDetailUseCase: GetHeroeDetailUseCaseContract{
    func execute(heroe: String, completion: @escaping (Result<Hero?, Error>) -> Void) {
        GetHeroesAPIRequest(name: heroe)
            .perform { result in
                switch result {
                case .success(let heroes):
                    let hero = heroes.first { $0.name.lowercased() == heroe.lowercased() }
                    completion(.success(hero))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
}
