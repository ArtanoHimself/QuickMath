
import UIKit

final class RegularButton: UIButton {
    
    enum Paddings {
        static let titleLabelFont: CGFloat = 30
        static let cornerRadius: CGFloat = 16
        static let buttonWidth: CGFloat = 200
        static let buttonHeight: CGFloat = 60
    }
    
    private var gradientLayer = CAGradientLayer()
    
    private let buttonTitle: String
    private let gradientColor: CGColor
    private let normalGradientColors: [CGColor]
    private let highlightedGradientColors: [CGColor]

    init(buttonTitle: String, gradientColor: CGColor) {
        self.gradientColor = gradientColor
        self.buttonTitle = buttonTitle
        
        self.normalGradientColors = [RGBColors.violet.cgColor, gradientColor]
        self.highlightedGradientColors = [RGBColors.lightRed.cgColor, gradientColor]
        
        super.init(frame: .zero)
        buttonSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buttonSettings() {
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(buttonTitle, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .systemFont(ofSize: Paddings.titleLabelFont)
        backgroundColor = RGBColors.violet
        layer.cornerRadius = Paddings.cornerRadius
        widthAnchor.constraint(equalToConstant: Paddings.buttonWidth).isActive = true
        heightAnchor.constraint(equalToConstant: Paddings.buttonHeight).isActive = true
        
        gradientLayer = makeGradient()
        layer.insertSublayer(gradientLayer, at: 0)
        clipsToBounds = true
    }
    
    private func makeGradient() -> CAGradientLayer {
        let gradient = CAGradientLayer()
    
        gradient.frame = CGRect.init(x: 0, y: 0, width: 200, height: 60)
        gradient.colors = [RGBColors.violet.cgColor, gradientColor]
        gradient.startPoint = CGPoint(x: 1, y: 0.5)
        gradient.endPoint = CGPoint(x: 0, y: 0)
        gradient.locations = [0.3, 2]
        
        return gradient
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                gradientLayer.colors = highlightedGradientColors
            } else {
                gradientLayer.colors = normalGradientColors
            }
        }
    }
}