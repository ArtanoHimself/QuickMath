
import Foundation

class LocalStorageFetchWorker {
    
    let storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    func fetchData() -> [PlayerInfo] {
        storage.fetchDataFromStorage()
    }
}
