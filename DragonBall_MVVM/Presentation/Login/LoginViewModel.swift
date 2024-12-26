import Foundation


// MARK: - LoginState Enum

/// Enum que representa los posibles estados de la operación de inicio de sesión.
///
/// - success: Indica que el inicio de sesión se realizó con éxito.
/// - error: Indica que hubo un error durante el inicio de sesión, con un motivo específico.
/// - loading: Indica que el proceso de inicio de sesión está en curso.
enum LoginState {
    case success
    case error(reason: String)
    case loading
}

// MARK: - LoginViewModel Class

/// Clase que gestiona la lógica de la vista para el proceso de inicio de sesión.
///
/// Esta clase se encarga de manejar el estado de la operación de inicio de sesión
/// y notificar a la interfaz de usuario sobre los cambios de estado a través de
/// un `Binding`.
final class LoginViewModel {
    
    // MARK: - Properties
    
    /// Binding que notifica a la interfaz de usuario sobre los cambios en el estado de inicio de sesión.
    let onStateChanged = Binding<LoginState>()
    
    /// Caso de uso responsable de ejecutar la lógica de inicio de sesión.
    private let useCase: LoginUseCaseContract
    
    // MARK: - Initializer
    
    /**
     Inicializa el `LoginViewModel` con un caso de uso específico.
     
     - Parameter useCase: El caso de uso que maneja la lógica de inicio de sesión.
     */
    init(useCase: LoginUseCaseContract) {
        self.useCase = useCase
    }
    
    // MARK: - Sign-In Method
    
    /**
     Realiza el inicio de sesión con las credenciales proporcionadas.
     
     - Parameters:
       - username: El nombre de usuario ingresado.
       - password: La contraseña ingresada.
     
     ## Descripción
     Este método actualiza el estado a `.loading` antes de intentar iniciar sesión
     con las credenciales. Al recibir el resultado del caso de uso, se actualiza
     el estado a `.success` en caso de éxito o a `.error` si ocurre algún error
     durante el proceso de inicio de sesión.
     */
    func signIn(_ username: String?, _ password: String?) {
        // Actualiza el estado a "cargando" antes de iniciar el proceso de inicio de sesión.
        onStateChanged.update(newValue: .loading)
        
        // Crea un objeto de credenciales con el nombre de usuario y la contraseña proporcionados.
        let credentials = Credentials(username: username ?? "", password: password ?? "")
        
        // Ejecuta el caso de uso para iniciar sesión.
        useCase.execute(credentials: credentials) { [weak self] result in
            do {
                // Intenta obtener el resultado; si tiene éxito, actualiza el estado a "éxito".
                try result.get()
                self?.onStateChanged.update(newValue: .success)
            } catch let error as LoginUseCaseError {
                // Si ocurre un error específico de inicio de sesión, actualiza el estado con el motivo del error.
                self?.onStateChanged.update(newValue: .error(reason: error.reason))
            } catch {
                // Para otros errores desconocidos, actualiza el estado con un mensaje de error genérico.
                self?.onStateChanged.update(newValue: .error(reason: "Unknown error"))
            }
        }
    }
}
