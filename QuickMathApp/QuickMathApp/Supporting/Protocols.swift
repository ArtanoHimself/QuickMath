
import Foundation

protocol Storage {
    func fetchDataFromStorage() -> [PlayerInfo]
    func addDataToStorage(playerInfo: PlayerInfo)
    func deleteDataFromStorage(target: PlayerInfo)
}

protocol CustomKeyboardDelegate: AnyObject {
    func didPressKey(value: String)
    func didPressMinusKey(value: String)
    func didPressErase()
}

