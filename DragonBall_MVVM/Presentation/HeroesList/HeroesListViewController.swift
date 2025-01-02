import UIKit

// MARK: - HeroesListViewController

/// Controlador de vista que muestra la lista de héroes.
///
/// Este controlador maneja la visualización de la lista de héroes,
/// incluyendo el manejo de estados como carga, éxito y error.
final class HeroesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var tableView: UITableView! // Tabla que muestra la lista de héroes.
    @IBOutlet private weak var errorLabel: UILabel! // Etiqueta que muestra el mensaje de error.
    @IBOutlet private weak var spinner: UIActivityIndicatorView! // Indicador de actividad para la carga.
    @IBOutlet private weak var errorContainer: UIStackView! // Contenedor que agrupa el mensaje de error.
    
    // MARK: - Properties
    
    private let viewModel: HeroesListViewModel // ViewModel que gestiona la lógica de la lista de héroes.
    
    // MARK: - Initializer
    
    /**
     Inicializa el controlador de vista con un ViewModel.
     
     - Parameter viewModel: El ViewModel para gestionar la lista de héroes.
     */
    init(viewModel: HeroesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "HeroesListView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bind()
        viewModel.load() // Carga la lista de héroes al iniciar la vista.
    }
    
    // MARK: - User Actions
    
    @IBAction func onRetryTapped(_ sender: Any) {
        viewModel.load() // Vuelve a cargar la lista de héroes si se toca el botón de reintentar.
    }
    
    // MARK: - Binding States
    
    private func bind() {
        viewModel.onStateChange.bind { [weak self] state in
            switch state {
            case .loading:
                self?.renderLoading() // Muestra la interfaz de carga.
            case .success:
                self?.renderSuccess() // Muestra la lista de héroes.
            case .error(let error):
                self?.renderError(error) // Muestra el error.
            }
        }
    }
    
    // MARK: - Rendering Functions
    
    /// Renderiza la vista en estado de error.
    ///
    /// - Parameter reason: La razón del error a mostrar.
    private func renderError(_ reason: String) {
        spinner.stopAnimating()
        errorContainer.isHidden = false
        tableView.isHidden = true
        errorLabel.text = reason // Muestra la razón del error en la etiqueta.
    }
    
    /// Renderiza la vista en estado de carga.
    private func renderLoading() {
        spinner.startAnimating()
        errorContainer.isHidden = true
        tableView.isHidden = true // Oculta la tabla y el contenedor de error.
    }
    
    /// Renderiza la vista en estado de éxito.
    private func renderSuccess() {
        spinner.stopAnimating()
        errorContainer.isHidden = true
        tableView.isHidden = false // Muestra la tabla con los héroes.
        tableView.reloadData() // Recarga la tabla con los datos de héroes.
    }

    // MARK: - Table View DataSource & Delegate Methods
    
    /// Retorna el número de filas en la sección de la tabla.
    ///
    /// - Parameters:
    ///   - tableView: La tabla en la que se está mostrando.
    ///   - section: La sección en la que se está mostrando.
    /// - Returns: El número de héroes.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.heroes.count // Retorna la cantidad de héroes disponibles.
    }
    
    /// Retorna la altura de cada fila en la tabla.
    ///
    /// - Parameters:
    ///   - tableView: La tabla en la que se está mostrando.
    ///   - indexPath: La posición de la fila.
    /// - Returns: La altura de la fila.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90 // Altura fija para cada celda.
    }
    
    /// Configura y retorna la celda para una fila específica.
    ///
    /// - Parameters:
    ///   - tableView: La tabla en la que se está mostrando.
    ///   - indexPath: La posición de la fila.
    /// - Returns: La celda configurada.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeroTableViewCell.reuseIdentifier, for: indexPath)
        if let cell = cell as? HeroTableViewCell {
            let hero = viewModel.heroes[indexPath.row] // Obtiene el héroe correspondiente.
            cell.setImage(hero.photo) // Configura la imagen del héroe.
            cell.setHeroName(hero.name) // Configura el nombre del héroe.
        }
        return cell // Retorna la celda configurada.
    }
    
    // MARK: - Table View Selection Handling
    
    /// Maneja la selección de una fila en la tabla.
    ///
    /// - Parameters:
    ///   - tableView: La tabla en la que se está mostrando.
    ///   - indexPath: La posición de la fila seleccionada.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hero = viewModel.heroes[indexPath.row] // Obtiene el héroe seleccionado.
        let heroDetailViewController = HeroeDetailBuilder(name: hero.name).build() // Crea el controlador de detalles del héroe.
        navigationController?.pushViewController(heroDetailViewController, animated: true) // Navega al controlador de detalles.
    }
    
    // MARK: - Setup Functions

    /// Configura la tabla de héroes.
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HeroTableViewCell.nib, forCellReuseIdentifier: HeroTableViewCell.reuseIdentifier)
        title = "Heroes" // Establece el título de la vista.
    }
}

