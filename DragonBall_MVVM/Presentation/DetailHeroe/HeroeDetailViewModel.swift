import Foundation


enum HeroeDetailState: Equatable {
    case success(Hero)
    case error
   
}


final class HeroeDetailViewModel {
    var onStateChanged = Binding<HeroeDetailState>()
    private(set) var heroe: Hero
    
    init(heroe: Hero) {
        self.heroe = heroe
    }
    
    func load() {
        onStateChanged.update(newValue: .success(heroe))
    }
}
