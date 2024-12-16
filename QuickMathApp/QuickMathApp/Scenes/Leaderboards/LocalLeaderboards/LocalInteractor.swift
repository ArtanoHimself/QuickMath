
import Foundation

final class LocalInteractor {
    
    var localPresenter: LocalPresenter?
    
    private let fetchWorker = LocalStorageFetchWorker(storage: UserDefaultsStorage())
    private let deleteWorker = LocalStorageDeleteWorker(storage: UserDefaultsStorage())
    
    func fetchDataFromStorage() {
        let data = fetchWorker.fetchData()
        localPresenter?.presentData(data: data)
    }
    
    func deleteDataFromStorage(target: PlayerInfo) {
        deleteWorker.deleteDataFromStorage(target: target)
        fetchDataFromStorage()
    }
}
