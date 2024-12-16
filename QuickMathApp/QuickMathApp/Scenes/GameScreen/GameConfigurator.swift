
import Foundation

final class GameConfigurator {
    
    static func configure(_ viewController: GameViewController) {
        let interactor = GameInteractor()
        let presenter = GamePresenter()
        
        interactor.gamePresenter = presenter
        presenter.gameViewController = viewController
        viewController.gameInteractor = interactor
    }
}
