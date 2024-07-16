//
//  FirebaseProtocols.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 8.07.2024.
//

import Foundation


//burada firebase protokollerini oluşturup dependency injection yasası gereği gerekli sınıflara bu protokolleri dışarıdan enjekte edeceğim. dolayısıyla, test edilebilirliği artacak, bağımlılık azalacak. */

import Foundation
import FirebaseFirestore
import FirebaseAuth

// Firebase Authentication protokolü: logIn ve createAccount sayfalarında kullanılacak 2 ana fonksiyon:
protocol FirebaseAuthProtocol {
   func logInWithEmail(withEmail email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?)
   func createNewUser(withEmail email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void)
    func logOut() throws
    
}

// Auth sınıfına protokol uyumluluğu ekleme:
/**auth sınıfı kullanıcı kimlik doğruama için kullanılır. Bu sınıf FireBase API'ını temsil eder. Kullanıcı işlemlerini yönetmeye yarar*/
extension Auth: FirebaseAuthProtocol {
 
   
   func logInWithEmail(withEmail email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?){
       signIn(withEmail: email, password: password, completion: completion)
   }
   
   func createNewUser(withEmail email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void){
       createUser(withEmail: email, password: password, completion: completion)
   }
    
    func logOut() throws {
        try Auth.auth().signOut()
    }
    
}

// Firestore protokolü
protocol FirestoreProtocol {
   func collection(_ collectionPath: String) -> CollectionReference
}

// Firestore sınıfına protokol uyumluluğu ekleme
extension Firestore: FirestoreProtocol {}
