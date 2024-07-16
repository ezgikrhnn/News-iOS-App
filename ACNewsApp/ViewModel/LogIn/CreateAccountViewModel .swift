//
//  CreateAccountViewModel .swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 4.07.2024.
//

/**UserModel sınıfında password adında bir özellik yok, çünkü şifre bir kullanıcı özelliği olarak saklanmıyor. şifreyi parametre olarak geçtim
 KCCreateAccountViewModel ile, kullanıcı oluşturulduktan sonra kullanıcı bilgilerini Firestore'a kaydediyoruz. Kullanıcı oluşturma işlemi ve Firestore'a veri yazma işlemi sırasında herhangi bir hata oluşursa, hata geri döndürülüyor. İşlemler başarılı olursa, başarı geri döndürülüyor
 **/

import Foundation
import FirebaseAuth
import FirebaseFirestore

// Kullanıcı oluşturma işlemleri için ViewModel protokolü
protocol CreateAccountViewModelProtocol {
    init(auth: FirebaseAuthProtocol, firestore: FirestoreProtocol) //protokoller de init alabilir.
    func createAccount(with userModel: UserModel, password: String, completion: @escaping (Result<UserModel, Error>) -> Void)
}

class CreateAccountViewModel: CreateAccountViewModelProtocol {
    
    private let auth: FirebaseAuthProtocol
    private let firestore: FirestoreProtocol
    
    required init(auth: FirebaseAuthProtocol = Auth.auth(), firestore: FirestoreProtocol = Firestore.firestore()) {
            self.auth = auth
            self.firestore = firestore
        }
    
    func createAccount(with userModel: UserModel, password: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        auth.createNewUser(withEmail: userModel.email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let authResult = authResult {
                let uid = authResult.user.uid
                let db = Firestore.firestore()
                let userRef = db.collection("users").document(uid)
                
                let data: [String: Any] = [
                    "name": userModel.name,
                    "surname": userModel.surname,
                    "email": userModel.email
                ]
                
                userRef.setData(data) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        let updatedUserModel = UserModel(name: userModel.name, surname: userModel.surname, email: userModel.email, uid: uid)
                        completion(.success(updatedUserModel))
                    }
                }
            }
        }
    }
}
