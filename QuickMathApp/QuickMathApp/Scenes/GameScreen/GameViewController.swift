
import UIKit

final class GameViewController: UIViewController {
    
    var gameInteractor: GameInteractor?
    
    enum Paddings {
        static let timerLabelFont: CGFloat = 25
        static let exampleLabelFont: CGFloat = 45
        static let answerLabelFont: CGFloat = 25
        
        static let headerBottomAnchorConstant: CGFloat = 130
        static let timerLabelTopAnchorConstant: CGFloat = 60
        static let scoreLabelTopAnchorConstant: CGFloat = 10
        static let exampleLabelCenterYAnchor: CGFloat = -200
        static let answerLabelCenterYAnchor: CGFloat = -100
        static let checkAnswerButtonCenterYAnchor: CGFloat = 50
        static let saveScoreButtonCenterYAnchor: CGFloat = 50
        static let keyboardTopAnchorConstant: CGFloat = 550
        static let keyboardBottomAnchorConstant: CGFloat = -30
        static let keyboardLeftAnchorConstant: CGFloat = 25
        static let keyboardRightAnchorConstant: CGFloat = -25
    }
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = RGBColors.violet
        return view
    }()
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: Paddings.timerLabelFont)
        label.text = "Time left: 30"
        label.textColor = .white
        return label
    }()
    
    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Current score: 0"
        label.textColor = .white
        return label
    }()
    
    private lazy var informationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = ""
        return label
    }()
    
    private lazy var exampleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "2 x 2 = ?"
        label.font = UIFont.systemFont(ofSize: Paddings.exampleLabelFont, weight: .semibold)
        return label
    }()
    
    private lazy var answerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Paddings.answerLabelFont, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = ""
        return label
    }()
    
    private lazy var checkAnswerButton = RegularButton(buttonTitle: "Check",
                                                       gradientColor: RGBColors.lightPurple.cgColor)
    
    private lazy var saveScoreButton = RegularButton(buttonTitle: "Save score",
                                                     gradientColor: RGBColors.lightGreen.cgColor)
    
    private lazy var customKeyboard: CustomKeyboard = {
        let board = CustomKeyboard()
        board.translatesAutoresizingMaskIntoConstraints = false
        return board
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        GameConfigurator.configure(self)
        setupUI()
        fetchMathExample()
        startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        gameInteractor?.invalidateTimers()
    }
    
    private func setupUI() {
        view.backgroundColor = RGBColors.darkerViolet
        view.addSubview(headerView)
        view.addSubview(timerLabel)
        view.addSubview(scoreLabel)
        view.addSubview(informationLabel)
        view.addSubview(exampleLabel)
        view.addSubview(answerLabel)
        view.addSubview(checkAnswerButton)
        view.addSubview(saveScoreButton)
        view.addSubview(customKeyboard)
        
        setConstraints()
        componentsSetup()
        setDelegates()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: view.topAnchor, constant:
                                                Paddings.headerBottomAnchorConstant),
            
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.topAnchor.constraint(equalTo: view.topAnchor,
                                            constant: Paddings.timerLabelTopAnchorConstant),
            
            scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreLabel.topAnchor.constraint(equalTo: timerLabel.bottomAnchor,
                                            constant: Paddings.scoreLabelTopAnchorConstant),
            
            informationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            informationLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            exampleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exampleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant:
                                                    Paddings.exampleLabelCenterYAnchor),
            
            answerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant:
                                                    Paddings.answerLabelCenterYAnchor),
            
            checkAnswerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkAnswerButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant:
                                                        Paddings.checkAnswerButtonCenterYAnchor),
            
            saveScoreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveScoreButton.centerYAnchor.constraint(equalTo: view.centerYAnchor,
                                                     constant: Paddings.saveScoreButtonCenterYAnchor),
            
            customKeyboard.topAnchor.constraint(equalTo: view.topAnchor, constant:
                                                    Paddings.keyboardTopAnchorConstant),
            customKeyboard.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:
                                                    Paddings.keyboardBottomAnchorConstant),
            customKeyboard.leftAnchor.constraint(equalTo: view.leftAnchor, constant:
                                                    Paddings.keyboardLeftAnchorConstant),
            customKeyboard.rightAnchor.constraint(equalTo: view.rightAnchor, constant:
                                                    Paddings.keyboardRightAnchorConstant)
        ])
    }
    
    private func componentsSetup() {
        saveScoreButton.isHidden = true
        checkAnswerButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        saveScoreButton.addTarget(self, action: #selector(saveScoreButtonTapped), for: .touchUpInside)
    }
    
    private func setDelegates() {
        customKeyboard.delegate = self
    }
    
    private func startTimer() {
        gameInteractor?.startTimer()
    }
    
    func fetchMathExample() {
        gameInteractor?.generateMathExample()
    }
    
    func displayMathExample(viewModel: MathExampleModels.ViewModel) {
        exampleLabel.text = viewModel.question
    }
    
    func showResult(message: String) {
        informationLabel.text = message
    }
    
    func updateCorrectResultColor() {
        informationLabel.textColor = RGBColors.lightGreen
    }
    
    func updateIncorrectResultColor() {
        informationLabel.textColor = RGBColors.lightRed
    }
    
    func updateCurrentScore(score: Int) {
        scoreLabel.text = "Current score: \(score)"
    }
    
    func updateTimerLabel(timeLeft: Int) {
        timerLabel.text = "Time left: \(timeLeft)"
    }
    
    func gameOverUI() {
        exampleLabel.isHidden = true
        answerLabel.isHidden = true
        checkAnswerButton.isHidden = true
        customKeyboard.isHidden = true
        saveScoreButton.isHidden = false
        informationLabel.textColor = .white
    }
    
    func updateTimerLabelToZero() {
        timerLabel.text = "Time left: 0"
    }
    
    func showScoreUpdate(info: String) {
        informationLabel.text = info
    }
    
    @objc private func checkButtonTapped() {
        if let answerText = answerLabel.text, let userAnswer = Int(answerText) {
            let answerRequest = MathExampleModels.AnswerRequest(userAnswer: userAnswer)
            gameInteractor?.checkAnswer(request: answerRequest)
            answerLabel.text = ""
        }
    }
    
    @objc private func saveScoreButtonTapped() {
        saveScoreButton.isHidden = true
        gameInteractor?.saveScore()
    }
}

extension GameViewController: CustomKeyboardDelegate {
     func didPressKey(value: String) {
        if let currentText = answerLabel.text {
            answerLabel.text = currentText + value
        } else {
            answerLabel.text = value
        }
    }
    
    func didPressMinusKey(value: String) {
        if let currentText = answerLabel.text {
            answerLabel.text = currentText + value
        } else {
            answerLabel.text = value
        }
    }
    
     func didPressErase() {
        answerLabel.text = ""
    }
}
