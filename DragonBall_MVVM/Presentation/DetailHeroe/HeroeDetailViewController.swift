import UIKit


/// Controlador de vista para mostrar los detalles de un héroe específico.
final class HeroeDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    /// Imagen del héroe.
    @IBOutlet private weak var heroeImageView: AsyncImageView!
    
    /// Etiqueta que muestra el nombre del héroe.
    @IBOutlet private weak var heroeUILabel: UILabel!
    
    /// Scroll view que contiene la información detallada del héroe.
    @IBOutlet private weak var scrollView: UIScrollView!
    
    /// Etiqueta que muestra la descripción del héroe.
    @IBOutlet private weak var characterLabelUILabel: UILabel!
    
    /// Contenedor de la vista de error.
    @IBOutlet private weak var errorContainer: UIStackView!
    
    /// Indicador de actividad que muestra el estado de carga.
    @IBOutlet private weak var loadingActivityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    /// ViewModel que maneja la lógica de negocio y el estado de los detalles del héroe.
    private let viewModel: HeroeDetailViewModel
    
    // MARK: - Initializers
    
    /**
     Inicializador personalizado para `HeroeDetailViewController`.
     
     - Parameters:
        - viewModel: Instancia de `HeroeDetailViewModel` que provee los datos y maneja la lógica.
     
     - Note: Este inicializador carga el nib correspondiente a la vista del detalle del héroe.
     */
    init(viewModel: HeroeDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "HeroeDetailView", bundle: Bundle(for: type(of: self)))
    }
    
    /**
     Inicializador requerido que no está implementado.
     
     - Parameter coder: Decoder utilizado para inicializar la vista desde un storyboard.
     
     - Note: Si se intenta inicializar `HeroeDetailViewController` desde un storyboard, la aplicación fallará.
     */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    
    /// Método llamado después de que la vista ha sido cargada.
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.load()
    }
    
    // MARK: - Binding
    
    /**
     Configura las vinculaciones entre el ViewModel y el controlador de vista.
     
     Observa los cambios en el estado del ViewModel y actualiza la interfaz de usuario en consecuencia.
     */
    private func bind() {
        viewModel.onStateChanged.bind { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .success:
                self.configureView()
            case .error:
                self.renderError()
            case .loading:
                self.renderLoading()
            }
        }
    }
    
    // MARK: - UI Configuration
    
    /**
     Configura la vista con los detalles del héroe cuando la carga es exitosa.
     
     - Note: Muestra los elementos de la interfaz con los datos del héroe y oculta el indicador de carga.
     */
    private func configureView() {
        heroeUILabel.text = viewModel.hero?.name
        characterLabelUILabel.text = viewModel.hero?.description
        if let photo = viewModel.hero?.photo {
            heroeImageView.setImage(photo)
        }
        
        loadingActivityIndicator.stopAnimating()
        heroeUILabel.isHidden = false
        characterLabelUILabel.isHidden = false
        heroeImageView.isHidden = false
        scrollView.isHidden = false
        errorContainer.isHidden = true
    }
    
    /**
     Configura la vista para mostrar el estado de carga.
     
     - Note: Muestra el indicador de carga y oculta los demás elementos de la interfaz.
     */
    private func renderLoading() {
        loadingActivityIndicator.startAnimating()
        scrollView.isHidden = true
        heroeUILabel.isHidden = true
        characterLabelUILabel.isHidden = true
        heroeImageView.isHidden = true
        errorContainer.isHidden = true
    }
    
    /**
     Configura la vista para mostrar un estado de error.
     
     - Note: Detiene el indicador de carga, oculta los elementos de la interfaz y muestra el contenedor de error.
     */
    private func renderError() {
        loadingActivityIndicator.stopAnimating()
        heroeUILabel.isHidden = true
        characterLabelUILabel.isHidden = true
        heroeImageView.isHidden = true
        errorContainer.isHidden = false
        scrollView.isHidden = true
    }
}
