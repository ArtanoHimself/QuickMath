
import Foundation

class LocalStorageSaveWorker {
    let storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    func addDataToStorage(nickName: String, score: Int) {
        let playerInfoToAdd = PlayerInfo(nickname: nickName, score: score)
        storage.addDataToStorage(playerInfo: playerInfoToAdd)
    }
}
