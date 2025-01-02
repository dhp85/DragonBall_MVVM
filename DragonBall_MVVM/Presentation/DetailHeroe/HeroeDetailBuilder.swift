import UIKit

/// Constructor para crear instancias de `HeroeDetailViewController` con sus dependencias necesarias.
final class HeroeDetailBuilder {
    
    // MARK: - Propiedades Privadas
    
    /// Nombre del héroe cuyos detalles se van a mostrar.
    private let name: String
    
    /// Caso de uso encargado de obtener los detalles del héroe.
    private let heroeUseCase: GetHeroeDetailUseCase
    
    /// ViewModel que maneja la lógica de negocio y el estado de los detalles del héroe.
    private let viewmodel: HeroeDetailViewModel
    
    // MARK: - Inicializador
    
    /**
     Inicializa una nueva instancia de `HeroeDetailBuilder`.
     
     - Parameters:
        - name: El nombre del héroe cuyos detalles se desean cargar.
     
     - Note: Este inicializador configura las dependencias necesarias, incluyendo el caso de uso y el ViewModel.
     */
    init(name: String) {
        self.name = name
        self.heroeUseCase = GetHeroeDetailUseCase() // Inicializamos el caso de uso
        self.viewmodel = HeroeDetailViewModel(heroName: name, useCase: heroeUseCase) // Configuramos el ViewModel con el nombre del héroe y el caso de uso
    }
    
    // MARK: - Métodos Públicos
    
    /**
     Construye y retorna una instancia de `HeroeDetailViewController` configurada con su ViewModel.
     
     - Returns: Una instancia de `UIViewController` que muestra los detalles del héroe.
     
     - Note: Este método encapsula la creación del controlador de vista, asegurando que todas las dependencias estén correctamente inyectadas.
     */
    func build() -> UIViewController {
        let viewController = HeroeDetailViewController(viewModel: viewmodel)
        return viewController
    }
}
