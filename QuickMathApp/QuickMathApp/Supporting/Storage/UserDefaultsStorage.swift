
import Foundation

class UserDefaultsStorage: Storage {
    
    private let defaults = UserDefaults.standard
    private let key = "UserDefaultsKey"
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func fetchDataFromStorage() -> [PlayerInfo] {
        guard let fetchedData = defaults.data(forKey: key) else { return [] }
        guard let decodedData = try? decoder.decode([PlayerInfo].self, from: fetchedData) else { return [] }
        return decodedData
    }
    
    func addDataToStorage(playerInfo: PlayerInfo) {
        var fetchedData = fetchDataFromStorage()
        fetchedData.append(playerInfo)
        let jsonData = try? encoder.encode(fetchedData)
        defaults.setValue(jsonData, forKey: key)
    }
    
    func deleteDataFromStorage(target: PlayerInfo) {
        var fetchedData = fetchDataFromStorage()
        let playerNickname = target.nickname
        let playerScore = target.score
        
        guard let index = fetchedData.firstIndex(where: {
            $0.nickname == playerNickname && $0.score == playerScore}) else { return }
        fetchedData.remove(at: index)
        
        let jsonData = try? encoder.encode(fetchedData)
        defaults.setValue(jsonData, forKey: key)
    }
}
