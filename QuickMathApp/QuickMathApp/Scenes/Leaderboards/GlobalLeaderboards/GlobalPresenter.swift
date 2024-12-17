
import Foundation

final class GlobalPresenter {
    
    weak var globalViewController: GlobalViewController?
    
    func presentPlayers(players: [FirebasePlayers]) {
        let sortedPlayers = players.sorted { $0.score > $1.score }
        globalViewController?.updateUI(with: sortedPlayers)
    }
    
    func presentError(error: String) {
        globalViewController?.displayError(error: error)
    }
}
