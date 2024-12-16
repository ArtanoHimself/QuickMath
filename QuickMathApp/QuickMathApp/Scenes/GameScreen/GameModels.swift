
import Foundation

struct MathExample {
    
    let question: String
    let answer: Int
}

struct ScoreResponse {
    var success: Bool
    var message: String
}

struct MathExampleModels {
    
    struct Response {
        let example: MathExample
    }
    
    struct ViewModel {
        let question: String
    }
    
    struct AnswerRequest {
        let userAnswer: Int
    }
    
    struct AnswerResponse {
        let isCorrect: Bool
    }
}
