import UIKit


// MARK: - LoginViewController Class

/// Controlador de vista para la interfaz de inicio de sesión.
///
/// Este controlador se encarga de gestionar la interacción del usuario
/// durante el proceso de inicio de sesión, así como de actualizar la interfaz
/// de usuario según el estado del inicio de sesión.
final class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    
    /// Campo de texto para el nombre de usuario.
    @IBOutlet private weak var userNameField: UITextField!
    
    /// Campo de texto para la contraseña.
    @IBOutlet private weak var passwordField: UITextField!
    
    /// Etiqueta para mostrar mensajes de error o información.
    @IBOutlet private weak var label: UILabel!
    
    /// Indicador de actividad para mostrar que se está procesando el inicio de sesión.
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
    /// Botón para iniciar sesión.
    @IBOutlet private weak var signingButton: UIButton!
    
    // MARK: - Properties
    
    /// El ViewModel que maneja la lógica de inicio de sesión.
    private let viewModel: LoginViewModel
    
    // MARK: - Initializer
    
    /**
     Inicializa el `LoginViewController` con un `LoginViewModel`.
     
     - Parameter viewModel: El ViewModel que gestiona la lógica de inicio de sesión.
     */
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "LoginView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind() // Establece el enlace entre el ViewModel y la vista.
        
        // Pre-llenar campos de texto con datos de prueba (puede eliminarse en producción).
        userNameField.text = "diegohp85@gmail.com"
        passwordField.text = "123456"
    }
    
    // MARK: - Actions
    
    /**
     Acción llamada cuando se presiona el botón de inicio de sesión.
     
     - Parameter sender: El objeto que envía la acción (en este caso, el botón).
     */
    @IBAction func onLoginButton(_ sender: Any) {
        // Llama al método de inicio de sesión en el ViewModel.
        viewModel.signIn(userNameField.text, passwordField.text)
    }
    
    // MARK: - Binding Method
    
    /// Establece el enlace entre el ViewModel y la vista para manejar los cambios de estado.
    private func bind() {
        viewModel.onStateChanged.bind { [weak self] state in
            switch state {
            case .success:
                self?.renderSuccess() // Llama a la función para renderizar el estado de éxito.
                self?.present(HeroesListBuilder().build(), animated: true) // Presenta la lista de héroes.
            case .error(reason: let reason):
                self?.renderError(reason) // Llama a la función para renderizar el estado de error.
            case .loading:
                self?.renderLoading() // Llama a la función para renderizar el estado de carga.
            }
        }
    }
    
    // MARK: - State Rendering Functions
    
    /// Renderiza la interfaz de usuario en caso de éxito en el inicio de sesión.
    private func renderSuccess() {
        signingButton.isHidden = false
        spinner.stopAnimating()
        label.isHidden = true
    }
    
    /// Renderiza la interfaz de usuario en caso de error con un mensaje específico.
    private func renderError(_ reason: String) {
        signingButton.isHidden = false
        spinner.stopAnimating()
        label.isHidden = false
        label.text = reason // Muestra el mensaje de error en la etiqueta.
    }
    
    /// Renderiza la interfaz de usuario en caso de que el inicio de sesión esté en progreso.
    private func renderLoading() {
        signingButton.isHidden = true
        spinner.startAnimating()
        label.isHidden = true
    }
}
