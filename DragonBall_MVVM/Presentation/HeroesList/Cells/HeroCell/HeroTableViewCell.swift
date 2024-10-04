import UIKit

final class HeroTableViewCell: UITableViewCell {
    static let reuseIdentifier = "HeroTableViewCell"
    static var nib: UINib {UINib(nibName: "HeroTableViewCell", bundle: Bundle(for: HeroTableViewCell.self))}
    
    @IBOutlet private weak var heroImageView: AsyncImageView!
    @IBOutlet private weak var nameHeroUILabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        heroImageView.cancel()
    }
    
    func setImage(_ image: String) {
        self.heroImageView.setImage(image)
    }
    
    func setHeroName(_ name: String) {
        self.nameHeroUILabel.text = name
    }

}
