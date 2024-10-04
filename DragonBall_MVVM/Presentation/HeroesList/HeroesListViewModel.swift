import Foundation

enum HeroesListState: Equatable {
    case loading
    case success
    case error(reason: String)
}

final class HeroesListViewModel {
    let onStateChange = Binding<HeroesListState>()
    private(set) var heroes: [Hero] = []
    private let useCase: GetAllHeroesUseCaseContract
    
    init(useCase: GetAllHeroesUseCaseContract) {
        self.useCase = useCase
    }
    
    func load() {
        onStateChange.update(newValue: .loading)
        useCase.execute { [weak self] result in
            do {
                self?.heroes = try result.get()
                self?.onStateChange.update(newValue: .success)
            }catch {
                self?.onStateChange.update(newValue: .error(reason: error.localizedDescription))
            }
        }
        
    }
    
    
}


