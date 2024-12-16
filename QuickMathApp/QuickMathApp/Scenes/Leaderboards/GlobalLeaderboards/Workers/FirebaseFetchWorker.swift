
import Foundation
import FirebaseFirestore

class FirebaseFetchWorker {
    
    private let database = Firestore.firestore()
    
    func fetchData(completion: @escaping (Result<[FirebasePlayers], Error>) -> Void) {
        
        database.collection("Leaderboards").getDocuments { (snapshot, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            var firebasePlayers: [FirebasePlayers] = []
            
            guard let documents = snapshot?.documents else {
                completion(.success([]))
                return
            }
            for document in documents {
                let data = document.data()
                if let nickname = data["nickname"] as? String,
                   let score = data["score"] as? Int {
                    let firebasePlayer = FirebasePlayers(nickname: nickname, score: score)
                    firebasePlayers.append(firebasePlayer)
                }
            }
            
            completion(.success(firebasePlayers))
        }
    }
}
