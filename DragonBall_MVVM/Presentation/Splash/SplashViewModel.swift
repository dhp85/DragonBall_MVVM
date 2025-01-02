import Foundation

// MARK: - SplashState Enum

/// Enumeración que representa los diferentes estados de la pantalla de splash.
enum SplashState {
    /// Estado que indica que la aplicación está cargando.
    case loading
    /// Estado que indica que ocurrió un error durante la carga.
    case error
    /// Estado que indica que la carga se completó y la aplicación está lista.
    case ready
}

// MARK: - SplashViewModel Class

/// ViewModel para la pantalla de splash que maneja la lógica de carga inicial de la aplicación.
final class SplashViewModel {
    
    // MARK: - Properties
    
    /// Binding que notifica a los observadores sobre cambios en el estado de la pantalla de splash.
    var onStateChanged = Binding<SplashState>()
    
    
    // MARK: - Public Methods
    
    /**
     Inicia el proceso de carga de la aplicación.
     
     ## Descripción
     Este método actualiza el estado a `.loading` para indicar que la carga ha comenzado.
     Luego, simula un retraso de 5 segundos (por ejemplo, para cargar recursos necesarios)
     y finalmente actualiza el estado a `.ready` para indicar que la carga se ha completado.
     
     ## Detalles
     - Utiliza `DispatchQueue.global().asyncAfter` para simular una operación asíncrona.
     - Captura `self` débilmente para evitar ciclos de retención.
     */
    func load() {
        // Actualiza el estado a `.loading` para indicar que la carga ha comenzado.
        onStateChanged.update(newValue: .loading)
        
        // Simula una operación asíncrona con un retraso de 5 segundos.
        DispatchQueue.global().asyncAfter(deadline: .now() + 5) { [weak self] in
            // Actualiza el estado a `.ready` para indicar que la carga se ha completado.
            self?.onStateChanged.update(newValue: .ready)
        }
    }
}
