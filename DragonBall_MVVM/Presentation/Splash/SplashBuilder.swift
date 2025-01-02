import UIKit

// MARK: - SplashBuilder Class

/// Clase encargada de construir el controlador de vista de splash.
///
/// Esta clase se encarga de crear e inicializar una instancia de `SplashViewController`
/// con su correspondiente `SplashViewModel`.
final class SplashBuilder {
    
    // MARK: - Build Method
    
    /**
     Crea y devuelve una instancia de `UIViewController`.
     
     - Returns: Un controlador de vista configurado para la pantalla de splash.
     
     ## Descripción
     Este método inicializa el `SplashViewModel` y lo utiliza para crear una
     instancia de `SplashViewController`. La configuración y la lógica de presentación
     se gestionan dentro de `SplashViewController`.
     */
    func build() -> UIViewController {
        // Inicializa el ViewModel para la pantalla de splash.
        let viewModel = SplashViewModel()
        
        // Crea y devuelve el controlador de vista de splash con el ViewModel.
        return SplashViewController(viewmodel: viewModel)
    }
}
