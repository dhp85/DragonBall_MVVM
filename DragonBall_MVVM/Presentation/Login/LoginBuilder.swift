import UIKit

// MARK: - LoginBuilder Class

/// Clase encargada de construir y configurar la vista de inicio de sesión.
///
/// Esta clase sigue el patrón de diseño Builder, facilitando la creación de
/// la jerarquía de objetos necesarios para presentar la pantalla de inicio de sesión.
final class LoginBuilder {
    
    // MARK: - Build Method
    
    /**
     Construye y devuelve un `UIViewController` para la vista de inicio de sesión.
     
     - Returns: Un controlador de vista configurado para el inicio de sesión.
     */
    func build() -> UIViewController {
        // Crea la instancia del caso de uso de inicio de sesión.
        let loginUseCase = LoginUseCase()
        
        // Crea la instancia del ViewModel de inicio de sesión utilizando el caso de uso.
        let viewModel = LoginViewModel(useCase: loginUseCase)
        
        // Crea la instancia del controlador de vista de inicio de sesión utilizando el ViewModel.
        let viewController = LoginViewController(viewModel: viewModel)
        
        // Configura la presentación modal para que ocupe toda la pantalla.
        viewController.modalPresentationStyle = .fullScreen
        
        // Retorna el controlador de vista configurado.
        return viewController
    }
}
