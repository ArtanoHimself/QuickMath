
import Foundation

final class LocalPresenter {
    
    weak var localViewController: LocalViewController?
    
    func presentData(data: [PlayerInfo]) {
        let sortedData = data.sorted { $0.score > $1.score }
        localViewController?.updateUI(with: sortedData)
    }
}
