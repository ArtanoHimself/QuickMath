
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class FirebaseAccountWorker {
    
    private let database = Firestore.firestore()
    
    func createNewUser(user: UserDataStruct, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        self.database.collection("Users").whereField("nickname", isEqualTo: user.nickname).getDocuments { snapshot, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let documents = snapshot?.documents, !documents.isEmpty {
                let customError = NSError(domain: "FireBaseAuth", code: -1,
                                          userInfo: [NSLocalizedDescriptionKey: "Nickname is already taken."])
                
                completion(.failure(customError))
                return
            }
            
            Auth.auth().createUser(withEmail: user.email, password: user.password) { [weak self] result, error in
                guard let self = self else { return }
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let firebaseUser = result?.user else {
                    let customError = NSError(domain: AuthErrorDomain,
                                              code: -1,
                                              userInfo: [NSLocalizedDescriptionKey: "User creation failed without an error"])
                    
                    completion(.failure(customError))
                    return
                }
                
                self.database.collection("Users").document(firebaseUser.uid).setData([
                    "nickname": user.nickname
                ]) { error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    } else {
                        firebaseUser.sendEmailVerification()
                        completion(.success(true))
                    }
                }
            }
        }
    }
    
    
    func signIn(user: UserDataStruct, completion: @escaping (Result<Bool, Error>) -> Void) {
        signOut()
        
        Auth.auth().signIn(withEmail: user.email, password: user.password) { [weak self] result, error in
            
            guard let self = self else { return }

            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let firebaseUser = result?.user else {
                completion(.failure(SignInError.invalidUser))
                return
            }
            
            if !firebaseUser.isEmailVerified {
                completion(.failure(SignInError.notVerified))
                signOut()
                return
            }
            
            self.database.collection("Users").document(firebaseUser.uid).getDocument { document, error in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let document = document, document.exists else {
                    let customError = NSError(domain: "Firestore Database",
                                              code: -1,
                                              userInfo: [NSLocalizedDescriptionKey: "User document does not exist"])
                    completion(.failure(customError))
                    return
                }
                
                let data = document.data()
                guard let nickname = data?["nickname"] as? String, !nickname.isEmpty else {
                    
                    let customError = NSError(domain: "Firestore",
                                              code: -1,
                                              userInfo: [NSLocalizedDescriptionKey: "Nickname does not exist or it's empty"])
                    completion(.failure(customError))
                    return
                }
                
                UserSession.shared.userId = firebaseUser.uid
                UserSession.shared.nickname = nickname
                completion(.success(true))
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
}

enum SignInError: Error {
    case invalidUser
    case notVerified
}
