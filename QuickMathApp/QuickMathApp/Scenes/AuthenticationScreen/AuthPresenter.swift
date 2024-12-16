
import Foundation

final class AuthPresenter {
    
    weak var authViewController: AuthViewController?
    
    func presentUser(response: AuthResponse) {
        if response.success {
            authViewController?.displaySuccess(message: response.message)
        } else {
            authViewController?.displayError(message: response.message)
        }
    }
}

