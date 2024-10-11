import UIKit


final class HeroeDetailViewController: UIViewController {
    @IBOutlet private weak var heroeImageView: AsyncImageView!
    @IBOutlet private weak var heroeUILabel: UILabel!
    @IBOutlet private weak var characterLabelUILabel: UILabel!
    
    private let viewModel: HeroeDetailViewModel
    
    
    init(viewModel: HeroeDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "HeroeDetailView", bundle: Bundle(for: type(of: self)))
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
            case .succes:
                self?.configureView()
            case .error:
                break
            case .loading:
                <#code#>
            }
        }
    }
    
    // MARK: - Configuration
    private func configureView() {
        heroeUILabel.text = viewModel.hero?.name
        characterLabelUILabel.text = viewModel.hero?.description
        if let photo = viewModel.hero?.photo {
            heroeImageView.setImage(photo)
        }
    }

}

