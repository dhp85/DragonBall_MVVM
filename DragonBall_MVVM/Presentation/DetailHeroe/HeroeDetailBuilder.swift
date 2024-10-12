import UIKit

final class HeroeDetailBuilder {
    private let name: String
    private let heroeUseCase: GetHeroeDetailUseCase
    private let viewmodel: HeroeDetailViewModel
    
    // Inicializador para asignar los valores
    init(name: String) {
        self.name = name
        self.heroeUseCase = GetHeroeDetailUseCase() // Inicializamos el caso de uso
        self.viewmodel = HeroeDetailViewModel(heroName: name, useCase: heroeUseCase) // Ahora podemos usar name
    }
    
    // Método build para construir el UIViewController
    func build() -> UIViewController {
        let viewController = HeroeDetailViewController(viewModel: viewmodel)
        return viewController
    }
}
