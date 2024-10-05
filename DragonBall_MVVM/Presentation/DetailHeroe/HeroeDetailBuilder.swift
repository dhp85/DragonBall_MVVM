import UIKit

final class HeroeDetailBuilder {
    func build(heroe: Hero) -> UIViewController {
        let viewModel = HeroeDetailViewModel(heroe: heroe)
        let viewController = HeroeDetailViewController(viewModel: viewModel)
        return viewController
    }
}
