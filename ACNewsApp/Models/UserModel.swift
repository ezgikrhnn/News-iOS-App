//
//  File.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 4.07.2024.
//

import Foundation
import FirebaseAuth

class UserModel {
    
    var name: String
    var surname: String
    var email: String
    var uid: String
    
    init(name: String, surname: String, email: String, uid: String) {
        self.name = name
        self.surname = surname
        self.email = email
        self.uid = uid
    }
    
    // Firebase'den gelen verilere göre bir UserModel örneği oluşturma
        static func fromFirebaseUser(_ user: User) -> UserModel {
            return UserModel(name: "", surname: "", email: user.email ?? "", uid: user.uid)
        }
}
