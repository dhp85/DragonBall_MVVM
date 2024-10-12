import Foundation

/// Clase genérica que facilita el enlace (binding) entre datos y sus observadores.
/// Utiliza un patrón de observación para notificar cambios en el estado.
final class Binding<State> {
    
    // MARK: - Typealiases
    
    /// Alias para el tipo de cierre que se ejecuta cuando el estado cambia.
    typealias Completion = (State) -> Void
    
    // MARK: - Properties
    
    /// Cierre que se ejecuta cuando el estado se actualiza.
    /// Es opcional para permitir la ausencia de observadores.
    var completion: Completion?
    
    // MARK: - Binding Method
    
    /**
     Asocia un observador al binding.
     
     - Parameter completion: Cierre que se ejecuta cada vez que el estado cambia.
     */
    func bind(completion: @escaping Completion) {
        self.completion = completion
    }
    
    // MARK: - Update Method
    
    /**
     Actualiza el estado y notifica al observador asociado.
     
     - Parameter newValue: El nuevo valor del estado.
     
     ## Descripción
     Esta función actualiza el estado actual con un nuevo valor y ejecuta el cierre de `completion` en el hilo principal para asegurar que las actualizaciones de la interfaz de usuario ocurran correctamente.
     */
    func update(newValue: State) {
        DispatchQueue.main.async { [weak self] in
            self?.completion?(newValue)
        }
    }
}
