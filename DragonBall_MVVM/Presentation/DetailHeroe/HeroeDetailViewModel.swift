import Foundation


/// Estado actual de los detalles del héroe.
enum HeroeDetailState: Equatable {
    /// Indica que la carga de datos fue exitosa.
    case success
    /// Indica que los datos se están cargando.
    case loading
    /// Indica que ocurrió un error al cargar los datos.
    case error
}

 
/// ViewModel para gestionar los detalles de un héroe específico.
final class HeroeDetailViewModel {
    
    // MARK: - Properties
    
    /// Enlace para notificar cambios en el estado de los detalles del héroe.
    let onStateChanged = Binding<HeroeDetailState>()
    
    /// Modelo que representa al héroe. Solo es modificable dentro de esta clase.
    private(set) var hero: Hero?
    
    /// Caso de uso para obtener los detalles del héroe.
    private var useCase: GetHeroeDetailUseCaseContract
    
    /// Nombre del héroe cuyo detalle se va a cargar.
    private let heroName: String
    
    // MARK: - Initializer
    
    /**
     Inicializa una nueva instancia de `HeroeDetailViewModel`.
     
     - Parameters:
        - heroName: El nombre del héroe cuyos detalles se desean cargar.
        - useCase: El caso de uso encargado de obtener los detalles del héroe.
     */
    init(heroName: String, useCase: GetHeroeDetailUseCaseContract) {
        self.heroName = heroName
        self.useCase = useCase
    }
    
    // MARK: - Public Methods
    
    /**
     Inicia la carga de los detalles del héroe.
     
     Cambia el estado a `.loading` antes de ejecutar el caso de uso.
     Actualiza el estado a `.success` si la carga es exitosa o a `.error` si ocurre un fallo.
     */
    func load() {
        onStateChanged.update(newValue: .loading)
        useCase.execute(heroe: heroName) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let hero):
                self.hero = hero
                self.onStateChanged.update(newValue: .success)
            case .failure:
                self.onStateChanged.update(newValue: .error)
            }
        }
    }
}
