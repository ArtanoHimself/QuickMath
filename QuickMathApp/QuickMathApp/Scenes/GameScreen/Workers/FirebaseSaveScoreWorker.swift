
import Foundation
import FirebaseFirestore

class FirebaseSaveScoreWorker {
    
    private let database = Firestore.firestore()
    
    func addDataToStorage(score: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let nickname = UserSession.shared.nickname
        let documentReference = database.collection("Leaderboards").document(nickname)
        
        documentReference.getDocument { (document, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let document = document, document.exists {
                if let oldScore = document.data()?["score"] as? Int {
                    if score <= oldScore {
                        completion(.success(false))
                        return
                    }
                }
            }
            
            let scoreData: [String: Any] = [
                "nickname": nickname,
                "score": score,
            ]
            
            documentReference.setData(scoreData) { error in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(true))
            }
        }
    }
}
