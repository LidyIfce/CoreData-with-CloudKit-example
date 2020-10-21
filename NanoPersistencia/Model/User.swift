//
//  User.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 08/10/20.
//

import Foundation
class User {
    let id: String
    let nome: String
    let email: String
    let password: String

    init(id: String , dictionary: [String: AnyObject]) {
        self.id = id
        self.nome = dictionary["nome"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.password = dictionary["password"] as? String ?? ""
    }
}
