
import Foundation

struct AuthRequest {
    var email: String
    var password: String
    var nickname: String
}

struct AuthResponse {
    var success: Bool
    var message: String
}
