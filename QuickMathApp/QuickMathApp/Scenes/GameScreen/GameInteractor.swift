
import Foundation

final class GameInteractor {
    
    var gamePresenter: GamePresenter?
    private let gameWorker = MathLogicWorker()
    private let localStorageWorker = LocalStorageSaveWorker(storage: UserDefaultsStorage())
    private let firebaseStorageWorker = FirebaseSaveScoreWorker()
    
    private var currentScore: Int = 0
    
    private var currentDifficulty: Int = 1
    private var difficultyTimer: Timer?
    
    private var timeLeft: Int = 30
    private var timeLeftTimer: Timer?
    
    private var currentAnswer: Int?
    
    func generateMathExample() {
        let example = gameWorker.generateMathematicalOperation()
        currentAnswer = example.answer
        
        let response = MathExampleModels.Response(example: example)
        gamePresenter?.presentMathExample(response: response)
    }
    
    func checkAnswer(request: MathExampleModels.AnswerRequest) {
        let isCorrect = request.userAnswer == currentAnswer
        let response = MathExampleModels.AnswerResponse(isCorrect: isCorrect)
        
        if isCorrect {
            addTime()
            addScore()
            gamePresenter?.presentAnswerCheck(response: response)
        } else {
            gamePresenter?.presentWrongAnswer()
        }
    }
    
    func startTimer() {
        invalidateTimers()
        
        timeLeftTimer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
        
        difficultyTimer = Timer.scheduledTimer(timeInterval: 10.0,
                                               target: self,
                                               selector: #selector(increaseDifficulty),
                                               userInfo: nil,
                                               repeats: true)
    }
    
    func saveScore() {
        let nickname = UserSession.shared.nickname
        
        localStorageWorker.addDataToStorage(nickName: nickname, score: currentScore)
        firebaseStorageWorker.addDataToStorage(score: currentScore) { result in
            switch result {
                
            case .success(_):
                let scoreResponse = ScoreResponse(success: true, message: "Your Score has been saved")
                self.gamePresenter?.updateScoreInfo(scoreResponse: scoreResponse)
                
            case .failure(let error):
                let scoreResponse = ScoreResponse(success: false, message: error.localizedDescription)
                self.gamePresenter?.updateScoreInfo(scoreResponse: scoreResponse)
            }
        }
    }
    
    @objc private func updateTimer() {
        if timeLeft > 0 {
            timeLeft -= 1
            gamePresenter?.updateTimeLeft(timeLeft: timeLeft)
        } else {
            invalidateTimers()
            gamePresenter?.endGame()
        }
    }
    
    @objc private func increaseDifficulty() {
        currentDifficulty += 1
    }
        
    private func addTime() {
        if currentDifficulty > 4 {
            timeLeft += 2
        } else {
            timeLeft += 6 - currentDifficulty
        }
        gamePresenter?.updateTimeLeft(timeLeft: timeLeft)
    }
    
    private func addScore() {
        currentScore += (4 + currentDifficulty)
        gamePresenter?.updateScore(score: currentScore)
    }
    
    func invalidateTimers() {
        timeLeftTimer?.invalidate()
        difficultyTimer?.invalidate()
    }
}
