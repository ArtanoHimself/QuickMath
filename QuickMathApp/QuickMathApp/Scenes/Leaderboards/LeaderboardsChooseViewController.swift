
import UIKit

final class LeaderboardsChooseViewController: UIViewController {
    
    enum Paddings {
        static let stackViewSpacing: CGFloat = 20
    }
    
    private lazy var localButton = RegularButton(buttonTitle: "Local", gradientColor: RGBColors.lightBlue.cgColor)
    private lazy var globalButton = RegularButton(buttonTitle: "Global", gradientColor: RGBColors.lightGreen.cgColor)
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = Paddings.stackViewSpacing
        return stack
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = RGBColors.darkerViolet
        view.addSubview(stackView)
        
        setupConstraints()
        componentsSetup()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func componentsSetup() {
        stackView.addArrangedSubview(localButton)
        stackView.addArrangedSubview(globalButton)
        
        localButton.addTarget(self, action: #selector(localButtonTapped), for: .touchUpInside)
        globalButton.addTarget(self, action: #selector(globalButtonTapped), for: .touchUpInside)
    }
    
    @objc private func localButtonTapped() {
        let vc = LocalViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func globalButtonTapped() {
        let vc = GlobalViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
