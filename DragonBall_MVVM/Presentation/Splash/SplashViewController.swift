//
import UIKit

final class SplashViewController: UIViewController {
    init() {
        super.init(nibName: "SplashView", bundle: Bundle(for: type(of: self)))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
