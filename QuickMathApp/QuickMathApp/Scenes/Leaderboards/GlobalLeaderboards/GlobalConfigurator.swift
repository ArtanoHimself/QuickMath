
import Foundation

final class GlobalConfigurator {
    
    static func configure(_ viewController: GlobalViewController) {
        let interactor = GlobalInteractor()
        let presenter = GlobalPresenter()
        
        interactor.globalPresenter = presenter
        presenter.globalViewController = viewController
        viewController.globalInteractor = interactor
    }
}
