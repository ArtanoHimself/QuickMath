
import UIKit

final class AuthViewController: UIViewController {
    
    var authInteractor: AuthInteractor?
    
    private var isToggled = false
    
    enum Paddings {
        static let authOptionsButtonCenterYAnchor: CGFloat = 70
        static let loginLabelFont: CGFloat = 35
        static let stackViewSpacing: CGFloat = 20
        static let loginLabelCenterYConstant: CGFloat = -300
        static let displayLabelLeadingConstant: CGFloat = 12
        static let displayLabelTrailingConstant: CGFloat = -12
        static let stackViewCenterYConstant: CGFloat = -150
    }
    
    private var authOptionsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create account", for: .normal)
        button.setTitleColor(RGBColors.lightBlue, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        return button
    }()
    
    private lazy var authLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Authentication"
        label.font = UIFont.systemFont(ofSize: Paddings.loginLabelFont, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var displayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.clipsToBounds = true
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var emailField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = "Enter your Email"
        field.textColor = .white
        field.textAlignment = .center
        field.clipsToBounds = true
        return field
    }()
    
    private lazy var passwordField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = "Enter your Password"
        field.isSecureTextEntry = true
        field.textColor = .white
        field.textAlignment = .center
        return field
    }()
    
    private lazy var nicknameField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = "Enter your Nickname"
        field.textColor = .white
        field.textAlignment = .center
        field.isHidden = true
        return field
    }()
    
    private lazy var loginButton: RegularButton = {
        let button = RegularButton(buttonTitle: "Log In", gradientColor: RGBColors.lightGreen.cgColor)
        return button
    }()
    
    private lazy var createButton: RegularButton = {
        let button = RegularButton(buttonTitle: "Create", gradientColor: RGBColors.lightBlue.cgColor)
        button.isHidden = true
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = Paddings.stackViewSpacing
        return stack
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        AuthConfigurator.configure(self)
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = RGBColors.darkerViolet
        view.addSubview(authOptionsButton)
        view.addSubview(authLabel)
        view.addSubview(displayLabel)
        view.addSubview(stackView)
        view.addSubview(loginButton)
        view.addSubview(createButton)
        
        setConstraints()
        componentsSetup()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            authOptionsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authOptionsButton.centerYAnchor.constraint(equalTo: view.centerYAnchor,
                                                       constant: Paddings.authOptionsButtonCenterYAnchor),
            
            authLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant:
                                                    Paddings.loginLabelCenterYConstant),
            
            displayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:
                                                    Paddings.displayLabelLeadingConstant),
            displayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:
                                                    Paddings.displayLabelTrailingConstant),
            displayLabel.topAnchor.constraint(equalTo: authLabel.bottomAnchor),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant:
                                                Paddings.stackViewCenterYConstant),
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func componentsSetup() {
        stackView.addArrangedSubview(emailField)
        stackView.addArrangedSubview(passwordField)
        stackView.addArrangedSubview(nicknameField)
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        createButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        authOptionsButton.addTarget(self, action: #selector(switchAuthInterface), for: .touchUpInside)
    }
    
    func displaySuccess(message: String) {
        displayLabel.text = message
    }
    
    func displayError(message: String) {
        displayLabel.text = message
    }
    
    @objc private func createButtonTapped() {
        displayLabel.text = "Wait, please"
        
        guard let email = emailField.text,
              let password = passwordField.text,
              let nickname = nicknameField.text else { return }
        
        let request = AuthRequest(email: email, password: password, nickname: nickname)
        authInteractor?.createUser(user: request)
        
        emailField.text = ""
        passwordField.text = ""
        nicknameField.text = ""
    }
    
    @objc private func loginButtonTapped() {
        displayLabel.text = "Wait, please"
        
        guard let email = emailField.text,
              let password = passwordField.text,
              let nickname = nicknameField.text else { return }

        let request = AuthRequest(email: email, password: password, nickname: nickname)
        authInteractor?.signIn(user: request)
        
        emailField.text = ""
        passwordField.text = ""
        nicknameField.text = ""
    }
    
    @objc private func switchAuthInterface() {
        isToggled.toggle()
        
        UIView.animate(withDuration: 0.3) {
            
            let isCreatingAccount = self.isToggled
            
            self.authOptionsButton.setTitle(isCreatingAccount ? "Have an account? Log in." : "Create an account.", for: .normal)
            
            self.createButton.isHidden = !isCreatingAccount
            self.nicknameField.isHidden = !isCreatingAccount
            self.loginButton.isHidden = isCreatingAccount
            
            self.createButton.alpha = isCreatingAccount ? 1 : 0
            self.nicknameField.alpha = isCreatingAccount ? 1 : 0
            self.loginButton.alpha = isCreatingAccount ? 0 : 1
            
            self.loginButton.isHidden = false
            self.createButton.isHidden = false
        }
    }
}
