
import UIKit

final class CustomKeyboard: UIView {
    
    weak var delegate: CustomKeyboardDelegate?
    
    private let rowOneTitle = ["1", "2", "3"]
    private let rowTwoTitle = ["4", "5", "6"]
    private let rowThreeTitle = ["7", "8", "9"]
    
    enum Paddings {
        static let rowStackSpacing: CGFloat = 10
        static let invisibleButtonWidth: CGFloat = 100
        static let invisibleButtonHeight: CGFloat = 60
    }
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var rowOneStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var rowTwoStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var rowThreeStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var rowFourStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var minusButton: UIButton = {
        let button = KeyboardButton(gradientColor: RGBColors.lightBlue.cgColor)
        button.setTitle("-", for: .normal)
        button.addTarget(self, action: #selector(MinusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var zeroButton: KeyboardButton = {
        let button = KeyboardButton(gradientColor: RGBColors.lightBlue.cgColor)
        button.setTitle("0", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var deleteButton: KeyboardButton = {
        let button = KeyboardButton(gradientColor: RGBColors.lightBlue.cgColor)
        button.setTitle("<-", for: .normal)
        button.addTarget(self, action: #selector(eraseButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupKeyboard()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupKeyboard()
    }
    
    private func setupKeyboard() {
        backgroundColor = RGBColors.darkerViolet
        addSubview(mainStack)
        
        setupConstraints()
        componentsSetup()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainStack.leftAnchor.constraint(equalTo: leftAnchor),
            mainStack.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    private func componentsSetup() {
        mainStack.addArrangedSubview(rowOneStack)
        mainStack.addArrangedSubview(rowTwoStack)
        mainStack.addArrangedSubview(rowThreeStack)
        mainStack.addArrangedSubview(rowFourStack)
        
        rowOneSetup()
        rowTwoSetup()
        rowThreeSetup()
        rowFourSetup()
    }
    
    private func rowOneSetup() {
        for buttonTitle in rowOneTitle {
            let button = KeyboardButton(gradientColor: RGBColors.lightBlue.cgColor)
            button.setTitle(buttonTitle, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            rowOneStack.addArrangedSubview(button)
        }
    }
    
    private func rowTwoSetup() {
        for buttonTitle in rowTwoTitle {
            let button = KeyboardButton(gradientColor: RGBColors.lightBlue.cgColor)
            button.setTitle(buttonTitle, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            rowTwoStack.addArrangedSubview(button)
        }
    }
    
    private func rowThreeSetup() {
        for buttonTitle in rowThreeTitle {
            let button = KeyboardButton(gradientColor: RGBColors.lightBlue.cgColor)
            button.setTitle(buttonTitle, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            rowThreeStack.addArrangedSubview(button)
        }
    }
    
    private func rowFourSetup() {
        rowFourStack.addArrangedSubview(minusButton)
        rowFourStack.addArrangedSubview(zeroButton)
        rowFourStack.addArrangedSubview(deleteButton)
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.title(for: .normal) else { return }
        delegate?.didPressKey(value: buttonTitle)
    }
    
    @objc private func MinusButtonTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.title(for: .normal) else { return }
        delegate?.didPressMinusKey(value: buttonTitle)
    }
    
    @objc private func eraseButtonTapped(_ sender: UIButton) {
        delegate?.didPressErase()
    }
}
