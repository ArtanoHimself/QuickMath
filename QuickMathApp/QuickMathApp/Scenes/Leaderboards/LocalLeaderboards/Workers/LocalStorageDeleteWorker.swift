
import Foundation

class LocalStorageDeleteWorker {
    
    let storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    func deleteDataFromStorage(target: PlayerInfo) {
        storage.deleteDataFromStorage(target: target)
    }
}
