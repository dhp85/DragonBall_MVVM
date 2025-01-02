
import UIKit


// MARK: - SplashViewController Class

/// Controlador de vista que maneja la pantalla de splash de la aplicación.
///
/// Esta clase se encarga de mostrar una animación de carga mientras se
/// inicia la aplicación y se comunica con el `SplashViewModel` para
/// actualizar la interfaz de usuario según el estado actual.
final class SplashViewController: UIViewController {
    
    // MARK: - Outlets
    
    /// Indicador de actividad que muestra la animación de carga.
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    /// Instancia del ViewModel que gestiona la lógica de la pantalla de splash.
    private let viewModel: SplashViewModel
    
    // MARK: - Initializers
    
    /**
     Inicializador de la clase `SplashViewController`.
     
     - Parameter viewmodel: El `SplashViewModel` que proporciona la lógica de carga.
     */
    init(viewmodel: SplashViewModel) {
        self.viewModel = viewmodel
        super.init(nibName: "SplashView", bundle: Bundle(for: type(of: self)))
    }

    /// Inicializador requerido que no se implementa, ya que este controlador no se
    /// debe inicializar desde un storyboard.
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    
    /// Método que se llama cuando la vista ha sido cargada en memoria.
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()  // Vincula el ViewModel a la interfaz de usuario.
        viewModel.load()  // Inicia el proceso de carga en el ViewModel.
    }
    
    // MARK: - Binding Method
    
    /// Vincula el ViewModel con la interfaz de usuario para reaccionar a cambios en el estado.
    private func bind() {
        // Observa cambios en el estado del ViewModel.
        viewModel.onStateChanged.bind { [weak self] state in
            switch state {
            case .loading:
                self?.setAnimation(true)  // Muestra el spinner durante la carga.
            case .ready:
                self?.setAnimation(false)  // Oculta el spinner al completar la carga.
                self?.present(LoginBuilder().build(), animated: true)  // Presenta la pantalla de login.
            case .error:
                // Manejo del estado de error podría implementarse aquí.
                break
            }
        }
    }
    
    // MARK: - Animation Method
    
    /**
     Controla la animación del indicador de actividad.
     
     - Parameter animating: Un valor booleano que indica si el spinner debe
     comenzar o detenerse.
     */
    private func setAnimation(_ animating: Bool) {
        switch spinner.isAnimating {
        case true where !animating:
            spinner.stopAnimating()  // Detiene la animación si se está animando.
        case false where animating:
            spinner.startAnimating()  // Inicia la animación si no se está animando.
        default:
            break  // No realiza ninguna acción si el estado ya es correcto.
        }
    }
}


