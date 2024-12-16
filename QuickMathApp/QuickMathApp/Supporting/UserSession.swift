
import Foundation

class UserSession {
    
    static let shared = UserSession()
    
    var userId: String?
    var nickname: String

    private init() {
        self.nickname = "Unknown player"
        self.userId = nil
    }
}
