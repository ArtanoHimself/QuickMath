
import UIKit

class CustomTextField: UITextField {
    
    private let textPadding = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 40)
    
    private var placeholderColor: UIColor = .lightGray
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
        
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
        
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    override func drawPlaceholder(in rect: CGRect) {
        guard let placeholder = self.placeholder else { return }
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: placeholderColor,
            .font: self.font ?? UIFont.systemFont(ofSize: 17)
        ]
        
        let attributedString = NSAttributedString(string: placeholder, attributes: attributes)
        attributedString.draw(in: rect)
    }
    
}
