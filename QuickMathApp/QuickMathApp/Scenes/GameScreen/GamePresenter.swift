
import Foundation

final class GamePresenter {
    
    weak var gameViewController: GameViewController?
    
    func presentMathExample(response: MathExampleModels.Response) {
        let viewModel = MathExampleModels.ViewModel(question: response.example.question)
        gameViewController?.displayMathExample(viewModel: viewModel)
    }
    
    func presentAnswerCheck(response: MathExampleModels.AnswerResponse) {
        if response.isCorrect {
            gameViewController?.showResult(message: "Correct!")
            gameViewController?.updateCorrectResultColor()
            gameViewController?.fetchMathExample()
        }
    }
    
    func presentWrongAnswer() {
        gameViewController?.showResult(message: "Incorrect!")
        gameViewController?.updateIncorrectResultColor()
    }
    
    
    func updateTimeLeft(timeLeft: Int) {
        gameViewController?.updateTimerLabel(timeLeft: timeLeft)
    }
    
    func updateScore(score: Int) {
        gameViewController?.updateCurrentScore(score: score)
    }

    func endGame() {
        gameViewController?.showResult(message: "Game Over!")
        gameViewController?.gameOverUI()
        gameViewController?.updateTimerLabelToZero()
    }
    
    func updateScoreInfo(scoreResponse: ScoreResponse) {
        if scoreResponse.success {
            gameViewController?.showScoreUpdate(info: scoreResponse.message)
        } else {
            gameViewController?.showScoreUpdate(info: scoreResponse.message)
        }
    }
}
