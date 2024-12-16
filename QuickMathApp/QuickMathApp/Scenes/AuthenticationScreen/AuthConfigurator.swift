
import Foundation

final class AuthConfigurator {
    
    static func configure(_ viewController: AuthViewController) {
        let interactor = AuthInteractor()
        let presenter = AuthPresenter()
        
        interactor.authPresenter = presenter
        presenter.authViewController = viewController
        viewController.authInteractor = interactor
    }
}
