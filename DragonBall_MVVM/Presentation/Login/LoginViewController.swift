import UIKit


final class LoginViewController: UIViewController {
    @IBOutlet private weak var userNameField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    @IBOutlet private weak var signingButton: UIButton!
    
    private let viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "LoginView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        viewModel.signIn(userNameField.text, passwordField.text)
    }
    
    private func bind() {
        viewModel.onStateChanged.bind { [weak self] state in
            switch state {
            case .success:
                self?.renderSuccess()
                self?.present(HeroesListBuilder().build(), animated: true)
            case .error(reason: let reason):
                self?.renderError(reason)
            case .loading:
                self?.renderLoading()
            }
        }
    }
    
    //MARK: - State rendering functions
    
    private func renderSuccess() {
        signingButton.isHidden = false
        spinner.stopAnimating()
        label.isHidden = true
        
    }
    
    private func renderError(_ reason: String) {
        signingButton.isHidden = false
        spinner.stopAnimating()
        label.isHidden = false
        label.text = reason
        
    }
    
    private func renderLoading() {
        signingButton.isHidden = true
        spinner.startAnimating()
        label.isHidden = true
        
    }
    
}

