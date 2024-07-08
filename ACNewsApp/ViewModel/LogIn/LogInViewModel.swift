//
//  LogInViewModel.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 4.07.2024.
//

import Foundation
import FirebaseFirestore

//KCLogInPageViewModelProtocol protokolu
protocol LogInViewModelProtocol: AnyObject {
    //oturum açma fonksiyonu, sınıfın dışından çağırılacak
    func loginUser(email: String, password: String, completion: @escaping (Result<UserModel, Error>)-> Void)
}

class LogInViewModel: LogInViewModelProtocol {
    
    private let auth: FirebaseAuthProtocol
    private let firestore: FirestoreProtocol
    
    //dependency injection constructor ile firebase servislerinin geçirilmesi :
    init(auth: FirebaseAuthProtocol, firestore: FirestoreProtocol) {
        self.auth = auth
        self.firestore = firestore
    }
    
    //kullanıcı girişlerini işleyen protocol fonksiyonu
    func loginUser(email: String, password: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        auth.logInWithEmail(withEmail: email, password: password) { authResult, error in
            //hata kontrolu: signInWithEmail anında hata varsa completion ile döndür
            if let error = error {
                completion(.failure(error))
            }//başarılı oturum açma durumu:
            else if let authResult = authResult { //authResult != nil --> kullanıcının authentification bilgilerini al:
                let uid = authResult.user.uid
                let db = Firestore.firestore()
                let userRef = db.collection("users").document(uid)
                
                //firestore'daki document al
                userRef.getDocument { document, error in
                    if let document = document, document.exists { //document mevcutluk kontrolu
                        if let data = document.data(),
                           let name = data["name"] as? String,
                           let surname = data["surname"] as? String,
                           let email = data["email"] as? String {
                           let userModel = UserModel(name: name, surname: surname, email: email, uid: uid)
                            completion(.success(userModel)) //veriler userModel nesnesine atanır
                        } else {
                            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Veri formatı hatası"])))
                        }
                    } else { //doc bulunamadı:
                        completion(.failure(error ?? NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Kullanıcı bulunamadı"])))
                    }
                }
            }
        }
    }
}
