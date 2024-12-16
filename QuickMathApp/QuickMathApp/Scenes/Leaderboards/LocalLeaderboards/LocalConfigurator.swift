
import Foundation

final class LocalConfigurator {
    
    static func configure(_ viewController: LocalViewController) {
        let interactor = LocalInteractor()
        let presenter = LocalPresenter()
        
        interactor.localPresenter = presenter
        presenter.localViewController = viewController
        viewController.localInteractor = interactor
    }
}
