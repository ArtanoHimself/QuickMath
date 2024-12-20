
import UIKit

final class GlobalViewController: UIViewController {
    
    var globalInteractor: GlobalInteractor?
    private var playerModels: [FirebasePlayers] = []
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(GlobalCell.self, forCellReuseIdentifier: "GlobalCell")
        table.backgroundColor = RGBColors.darkerViolet
        return table
    }()
    
    private lazy var displayErrorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GlobalConfigurator.configure(self)
        globalInteractor?.fetchDataFromStorage()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = RGBColors.darkerViolet
        view.addSubview(tableView)
        view.addSubview(displayErrorLabel)
        
        setConstraints()
        setDelegates()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            displayErrorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            displayErrorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func updateUI(with viewModels: [FirebasePlayers]) {
        self.playerModels = viewModels
        tableView.reloadData()
    }
    
    func displayError(error: String) {
        tableView.isHidden = true
        displayErrorLabel.isHidden = false
        displayErrorLabel.text = error
    }
}

extension GlobalViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        playerModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GlobalCell", for: indexPath) as? GlobalCell
        cell?.selectionStyle = .none
        let playerInfo = playerModels[indexPath.row]
        cell?.playerInfoLabel.text = "\(playerInfo.nickname) - \(playerInfo.score)"
        return cell ?? UITableViewCell()
    }
}
