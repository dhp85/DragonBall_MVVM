import Foundation

// MARK: - Protocols

/// Protocolo que define el contrato para el caso de uso de inicio de sesión.
protocol LoginUseCaseContract {
    /**
     Ejecuta el proceso de inicio de sesión con las credenciales proporcionadas.
     
     - Parameters:
        - credentials: Las credenciales del usuario necesarias para el inicio de sesión.
        - completion: Closure que se ejecuta al completar el proceso de inicio de sesión. Retorna un `Result` que puede ser `.success` si el inicio de sesión fue exitoso o `.failure` con un `LoginUseCaseError` si ocurrió un error.
     */
    func execute(credentials: Credentials, completion: @escaping (Result<Void, LoginUseCaseError>) -> Void)
}

// MARK: - Classes

/// Caso de uso responsable de manejar el proceso de inicio de sesión.
final class LoginUseCase: LoginUseCaseContract {
    
    // MARK: - Properties
    
    /// Fuente de datos para manejar la sesión del usuario.
    private let dataSource: SessionDataSourceContract
    
    // MARK: - Initializers
    
    /**
     Inicializa una nueva instancia de `LoginUseCase`.
     
     - Parameter dataSource: Fuente de datos que implementa `SessionDataSourceContract`. Por defecto, utiliza una instancia de `SessionDataSource`.
     
     - Note: Esta inyección de dependencias facilita la prueba y el mantenimiento del código.
     */
    init(dataSource: SessionDataSourceContract = SessionDataSource()) {
        self.dataSource = dataSource
    }
    
    // MARK: - Public Methods
    
    /**
     Ejecuta el proceso de inicio de sesión con las credenciales proporcionadas.
     
     - Parameters:
        - credentials: Las credenciales del usuario necesarias para el inicio de sesión.
        - completion: Closure que se ejecuta al completar el proceso de inicio de sesión. Retorna un `Result` que puede ser `.success` si el inicio de sesión fue exitoso o `.failure` con un `LoginUseCaseError` si ocurrió un error.
     
     - Note: Valida el nombre de usuario y la contraseña antes de realizar la solicitud de inicio de sesión a través de `LoginAPIRequest`.
     */
    func execute(credentials: Credentials, completion: @escaping (Result<Void, LoginUseCaseError>) -> Void) {
        // Validación del nombre de usuario
        guard validateUsername(credentials.username) else {
            return completion(.failure(LoginUseCaseError(reason: "Correo electrónico inválido")))
        }
        
        // Validación de la contraseña
        guard validatePassword(credentials.password) else {
            return completion(.failure(LoginUseCaseError(reason: "Contraseña inválida")))
        }
        
        // Realiza la solicitud de inicio de sesión
        LoginAPIRequest(credentials: credentials)
            .perform { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let token):
                    // Almacena el token de sesión en la fuente de datos
                    self.dataSource.storeSession(token)
                    completion(.success(()))
                case .failure:
                    // Maneja el error de red
                    completion(.failure(LoginUseCaseError(reason: "Fallo de Red")))
                }
            }
    }
    
    // MARK: - Private Methods
    
    /**
     Valida el nombre de usuario proporcionado.
     
     - Parameter username: El nombre de usuario que se desea validar.
     - Returns: `Bool` indicando si el nombre de usuario es válido.
     
     - Note: En este ejemplo, un nombre de usuario válido debe contener un "@" y no estar vacío.
     */
    private func validateUsername(_ username: String) -> Bool {
        username.contains("@") && !username.isEmpty
    }
    
    /**
     Valida la contraseña proporcionada.
     
     - Parameter password: La contraseña que se desea validar.
     - Returns: `Bool` indicando si la contraseña es válida.
     
     - Note: En este ejemplo, una contraseña válida debe tener al menos 4 caracteres.
     */
    private func validatePassword(_ password: String) -> Bool {
        password.count >= 4
    }
}

// MARK: - Structures

/// Estructura que representa un error en el caso de uso de inicio de sesión.
struct LoginUseCaseError: Error {
    /// Razón que describe el error ocurrido durante el inicio de sesión.
    let reason: String
}
