
import Foundation

final class GlobalInteractor {
    
    var globalPresenter: GlobalPresenter?
    
    private let firebaseFetchWorker = FirebaseFetchWorker()
    
    func fetchDataFromStorage() {
        firebaseFetchWorker.fetchData { result in
            
            switch result {
                
            case .success(let firebasePlayers):
                self.globalPresenter?.presentPlayers(players: firebasePlayers)
            case .failure(let error):
                self.globalPresenter?.presentError(error: error.localizedDescription)
            }
        }
    }
}
