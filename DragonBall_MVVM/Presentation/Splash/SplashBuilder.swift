import UIKit

final class SplashBuilder {
    func build() -> UIViewController {
        let viewModel = SplashViewModel()
        return SplashViewController(viewmodel: viewModel)
    }
}
