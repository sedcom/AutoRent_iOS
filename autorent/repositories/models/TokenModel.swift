//
//  TokenModel.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 28.01.2022.
//

import Foundation

class TokenModel: Encodable {
    var Login: String
    var Password: String
    
    init (login: String, password: String) {
        self.Login = login
        self.Password = password
    }
}
