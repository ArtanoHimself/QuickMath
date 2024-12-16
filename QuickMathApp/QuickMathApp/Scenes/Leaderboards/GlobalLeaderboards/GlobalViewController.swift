
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GlobalConfigurator.configure(self)
        globalInteractor?.fetchDataFromStorage()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = RGBColors.darkerViolet
        view.addSubview(tableView)
        
        setConstraints()
        setDelegates()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
}

extension GlobalViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        playerModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GlobalCell", for: indexPath) as? GlobalCell
        let playerInfo = playerModels[indexPath.row]
        cell?.playerInfoLabel.text = "\(playerInfo.nickname) - \(playerInfo.score)"
        return cell ?? UITableViewCell()
    }
}
