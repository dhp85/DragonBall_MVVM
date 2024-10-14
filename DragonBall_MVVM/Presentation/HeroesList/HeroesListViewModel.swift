import Foundation

// MARK: - HeroesListState Enum

/// Enum que representa los posibles estados de la lista de héroes.
enum HeroesListState: Equatable {
    /// Estado que indica que la carga de héroes está en progreso.
    case loading
    
    /// Estado que indica que la lista de héroes se ha cargado con éxito.
    case success
    
    /// Estado que indica que ha ocurrido un error durante la carga de héroes.
    /// - Parameter reason: La razón del error.
    case error(reason: String)
}

// MARK: - HeroesListViewModel Class

/// ViewModel que gestiona la lógica de la lista de héroes.
///
/// Este ViewModel interactúa con el caso de uso para obtener la lista de héroes
/// y notifica a la vista sobre los cambios en el estado.
final class HeroesListViewModel {
    
    // MARK: - Properties
    
    /// Binding que notifica a la vista sobre los cambios en el estado de la lista de héroes.
    let onStateChange = Binding<HeroesListState>()
    
    /// La lista de héroes obtenida.
    private(set) var heroes: [Hero] = []
    
    /// Caso de uso que proporciona la lógica para obtener todos los héroes.
    private let useCase: GetAllHeroesUseCaseContract
    
    // MARK: - Initializer
    
    /**
     Inicializa el `HeroesListViewModel` con un caso de uso específico.
     
     - Parameter useCase: El caso de uso para obtener todos los héroes.
     */
    init(useCase: GetAllHeroesUseCaseContract) {
        self.useCase = useCase
    }
    
    // MARK: - Load Method
    
    /// Carga la lista de héroes y actualiza el estado.
    func load() {
        // Actualiza el estado a 'loading' antes de iniciar la carga.
        onStateChange.update(newValue: .loading)
        
        // Ejecuta el caso de uso para obtener la lista de héroes.
        useCase.execute { [weak self] result in
            do {
                // Intenta obtener la lista de héroes del resultado.
                self?.heroes = try result.get()
                
                // Actualiza el estado a 'success' si la carga fue exitosa.
                self?.onStateChange.update(newValue: .success)
            } catch {
                // Actualiza el estado a 'error' si ocurre un fallo, proporcionando la razón del error.
                self?.onStateChange.update(newValue: .error(reason: error.localizedDescription))
            }
        }
    }
}

