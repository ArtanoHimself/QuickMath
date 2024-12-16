
import Foundation

final class AuthInteractor {
    
    var authPresenter: AuthPresenter?
    var firebaseAccountWorker = FirebaseAccountWorker()
    
    func createUser(user: AuthRequest ) {
        let user = UserDataStruct(email: user.email, password: user.password, nickname: user.nickname )
        firebaseAccountWorker.createNewUser(user: user) { result in
            switch result {
                
            case .success:
                let response = AuthResponse(success: true, message: "Verification email has been sent.")
                self.authPresenter?.presentUser(response: response)
            case .failure(let error):
                let response = AuthResponse(success: false, message: error.localizedDescription)
                self.authPresenter?.presentUser(response: response)
            }
        }
    }
    
    func signIn(user: AuthRequest ) {
        let user = UserDataStruct(email: user.email, password: user.password, nickname: user.nickname)
        firebaseAccountWorker.signIn(user: user) { result in
            switch result {
            case .success:
                let response = AuthResponse(success: true, message: "Sign in successful.")
                self.authPresenter?.presentUser(response: response)
            case .failure(let error):
                let response = AuthResponse(success: false, message: error.localizedDescription)
                self.authPresenter?.presentUser(response: response)
            }
        }
    }
}
    
    
    

