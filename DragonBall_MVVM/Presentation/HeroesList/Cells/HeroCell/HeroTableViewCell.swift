import UIKit

// MARK: - HeroTableViewCell

/// Clase que representa una celda personalizada para mostrar los detalles de un héroe en una UITableView.
///
/// Esta celda incluye un UIImageView para mostrar la imagen del héroe y una UILabel para mostrar su nombre.
final class HeroTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    /// Identificador reutilizable para la celda.
    static let reuseIdentifier = "HeroTableViewCell"
    
    /// Nib asociado a esta celda para ser usado en la inicialización.
    static var nib: UINib {
        UINib(nibName: "HeroTableViewCell", bundle: Bundle(for: HeroTableViewCell.self))
    }
    
    // MARK: - Outlets
    
    /// UIImageView para mostrar la imagen del héroe.
    @IBOutlet private weak var heroImageView: AsyncImageView!
    
    /// UILabel para mostrar el nombre del héroe.
    @IBOutlet private weak var nameHeroUILabel: UILabel!
    
    // MARK: - UITableViewCell Lifecycle
    
    /// Preparación de la celda para su reutilización.
    ///
    /// Este método se llama antes de que la celda se reutilice. Se utiliza para cancelar cualquier carga de imagen previa.
    override func prepareForReuse() {
        super.prepareForReuse()
        heroImageView.cancel() // Cancela la carga de la imagen anterior.
    }
    
    // MARK: - Configuration Methods
    
    /// Configura la imagen de la celda.
    ///
    /// - Parameter image: URL de la imagen que se debe mostrar.
    func setImage(_ image: String) {
        self.heroImageView.setImage(image) // Establece la imagen utilizando el AsyncImageView.
    }
    
    /// Configura el nombre del héroe que se mostrará en la celda.
    ///
    /// - Parameter name: Nombre del héroe que se debe mostrar.
    func setHeroName(_ name: String) {
        self.nameHeroUILabel.text = name // Asigna el nombre al UILabel.
    }
}
