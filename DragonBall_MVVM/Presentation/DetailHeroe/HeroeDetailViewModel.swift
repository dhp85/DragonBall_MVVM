import Foundation


enum HeroeDetailState: Equatable {
    case success
    case loading
    case error
}


final class HeroeDetailViewModel {
    let onStateChanged = Binding<HeroeDetailState>()
    private(set) var hero: Hero?
    private var useCase = GetHeroeDetailUseCase()
    private let heroName: String
    
    init(heroName: String, useCase: GetHeroeDetailUseCase) {
        self.heroName = heroName
        self.useCase = useCase
    }
    
    
    
    func load() {
        onStateChanged.update(newValue: .loading)
        useCase.execute(heroe: heroName) { [weak self] result in
            switch result {
            case .success(let hero):
                self?.hero = hero
                self?.onStateChanged.update(newValue: .success)
            case .failure:
                self?.onStateChanged.update(newValue: .error)
            }
        }
    }
}
