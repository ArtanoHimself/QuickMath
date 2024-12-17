
import UIKit

final class LocalViewController: UIViewController {
    
    private var playerModels: [PlayerInfo] = []
    var localInteractor: LocalInteractor?
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(LocalCell.self, forCellReuseIdentifier: "LocalCell")
        table.backgroundColor = RGBColors.darkerViolet
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocalConfigurator.configure(self)
        localInteractor?.fetchDataFromStorage()
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
    
    func updateUI(with viewModels: [PlayerInfo]) {
        self.playerModels = viewModels
        tableView.reloadData()
    }
}

extension LocalViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocalCell", for: indexPath) as? LocalCell
        cell?.selectionStyle = .none
        let playerInfo = playerModels[indexPath.row]
        cell?.playerInfoLabel.text = "\(playerInfo.nickname) - \(playerInfo.score)"
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, completionHandler in
            
            let playerToDelete = self.playerModels[indexPath.row]
            self.localInteractor?.deleteDataFromStorage(target: playerToDelete)
            completionHandler(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
