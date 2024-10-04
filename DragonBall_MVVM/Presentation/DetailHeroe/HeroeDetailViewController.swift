import UIKit


final class HeroeDetailViewController: UIViewController {
    @IBOutlet private weak var heroeImageView: AsyncImageView!
    @IBOutlet private weak var nameTransformationUIButton: UIButton!
    @IBOutlet private weak var heroeUILabel: UILabel!
    @IBOutlet private weak var characterLabelUILabel: UILabel!
    
    private let viewModel: HeroeDetailViewModel
    
    
    init(viewModel: HeroeDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "DetailHeroeView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.load()
        
    }
    
    private func bind() {
        viewModel.onStateChanged.bind { [ weak self] state in
            switch state {
            case .success(let heroe):
                self?.configureView(with: heroe)
            case .error:
                break
            }
        }
    }
    
    // MARK: - Configuration
    private func configureView(with heroe: Hero) {
        heroeImageView.setImage(heroe.photo)
        heroeUILabel.text = heroe.name
        characterLabelUILabel.text = heroe.description
    }

}

