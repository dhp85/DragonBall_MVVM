import Foundation

// MARK: - SessionDataSourceContract Protocol

/// Protocolo que define las operaciones para manejar la sesión del usuario.
///
/// Este protocolo especifica métodos para almacenar y recuperar la sesión del usuario.
protocol SessionDataSourceContract {
    
    /// Almacena los datos de sesión.
    ///
    /// - Parameter session: Los datos de sesión que se desean almacenar.
    func storeSession(_ session: Data)
    
    /// Recupera los datos de sesión almacenados.
    ///
    /// - Returns: Los datos de sesión almacenados o `nil` si no hay sesión disponible.
    func getSession() -> Data?
}

// MARK: - SessionDataSource Class

/// Clase que implementa el protocolo `SessionDataSourceContract`
/// para manejar la sesión del usuario en memoria.
final class SessionDataSource: SessionDataSourceContract {
    
    // MARK: - Properties
    
    /// Token de sesión almacenado.
    /// Este es un almacenamiento estático que puede ser accedido a través de la clase.
    private static var token: Data?
    
    // MARK: - SessionDataSourceContract Methods
    
    /// Almacena los datos de sesión.
    ///
    /// - Parameter session: Los datos de sesión que se desean almacenar.
    func storeSession(_ session: Data) {
        SessionDataSource.token = session
    }
    
    /// Recupera los datos de sesión almacenados.
    ///
    /// - Returns: Los datos de sesión almacenados o `nil` si no hay sesión disponible.
    func getSession() -> Data? {
        SessionDataSource.token
    }
}
