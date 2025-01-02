import UIKit

// MARK: - HeroesListBuilder

/// Clase responsable de construir el controlador de vista para la lista de héroes.
///
/// Esta clase crea y configura el ViewModel y el ViewController necesarios para mostrar
/// la lista de héroes, además de encapsular la lógica para la presentación.
final class HeroesListBuilder {
    
    // MARK: - Build Method
    
    /**
     Construye y retorna un controlador de vista encapsulado en un UINavigationController.
     
     - Returns: Un UINavigationController que contiene el HeroesListViewController.
     */
    func build() -> UIViewController {
        let useCase = GetAllHeroesUseCase() // Crea una instancia del caso de uso para obtener todos los héroes.
        let viewModel = HeroesListViewModel(useCase: useCase) // Crea el ViewModel con el caso de uso.
        let viewController = HeroesListViewController(viewModel: viewModel) // Crea el controlador de vista con el ViewModel.
        
        // Configura el controlador de navegación con el controlador de vista.
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen // Establece el estilo de presentación a pantalla completa.
        
        return navigationController // Retorna el controlador de navegación.
    }
}
