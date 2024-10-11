import Foundation


enum HeroeDetailState: Equatable {
    case succes
    case loading
    case error
}


final class HeroeDetailViewModel {
    let onStateChanged = Binding<HeroeDetailState>()
    private(set) var hero: Hero?
    private let useCase: GetHeroeDetailUseCaseContract
    private let heroName: String
    
    init(heroName: String, useCase: GetHeroeDetailUseCaseContract) {
        self.heroName = heroName
        self.useCase = useCase
    }
    
    
    
    func load() {
        onStateChanged.update(newValue: .loading)
        useCase.execute(heroe: heroName) { [weak self] result in
            switch result {
            case .success(let heroe):
                self?.onStateChanged.update(newValue: .succes)
            case .failure:
                self?.onStateChanged.update(newValue: .error)
            }
        }
    }
}
