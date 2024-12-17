
import UIKit

final class MainMenuViewController: UIViewController {
    
    enum Paddings {
        static let gameLabelFont: CGFloat = 40
        static let stackViewSpacing: CGFloat = 20
        static let gameLabelCenterYConstant: CGFloat = -300
        static let versionLabelBottomAnchorConstant: CGFloat = -20
    }
    
    private lazy var gameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Quick math"
        label.font = UIFont.systemFont(ofSize: Paddings.gameLabelFont, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var newGameButton = RegularButton(buttonTitle: "New game",
                                                   gradientColor: RGBColors.lightPurple.cgColor)
    private lazy var profileButton = RegularButton(buttonTitle: "Profile",
                                                   gradientColor: RGBColors.lightGreen.cgColor)
    private lazy var leaderboardsButton = RegularButton(buttonTitle: "Leaderboards",
                                                        gradientColor: RGBColors.lightBlue.cgColor)
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = Paddings.stackViewSpacing
        return stack
    }()
    
    private lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Version 1.1"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = RGBColors.darkerViolet
        view.addSubview(gameLabel)
        view.addSubview(stackView)
        view.addSubview(versionLabel)
        
        setConstraints()
        componentsSetup()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
           gameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           gameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor,
                                              constant: Paddings.gameLabelCenterYConstant),
           
           stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
           
           versionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                constant: Paddings.versionLabelBottomAnchorConstant),
           versionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func componentsSetup() {
        stackView.addArrangedSubview(newGameButton)
        stackView.addArrangedSubview(profileButton)
        stackView.addArrangedSubview(leaderboardsButton)
        
        newGameButton.addTarget(self, action: #selector(presentTest), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(presentProfileScreen), for: .touchUpInside)
        leaderboardsButton.addTarget(self, action: #selector(presentLeaderboardsScreen), for: .touchUpInside)
    }
    
    @objc private func presentTest() {
        let vc = GameViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func presentProfileScreen() {
        let vc = AuthViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func presentLeaderboardsScreen() {
        let vc = LeaderboardsChooseViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
