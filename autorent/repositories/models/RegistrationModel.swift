//
//  RegistrationModel.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 05.02.2022.
//

import Foundation


class RegistrationModel: Encodable {
    var Login: String
    var Password: String
    var RepeatPassword: String
    var ActivateType: Int
    var Email: String
    var Phone: String
    
    init() {
        self.Login = ""
        self.Password = ""
        self.RepeatPassword = ""
        self.ActivateType = 1
        self.Email = ""
        self.Phone = ""
    }
    
    func encode(to encoder: Encoder) throws {
         var container = encoder.container(keyedBy: CodingKeys.self)
         try container.encode(self.Login, forKey: .Login)
         try container.encode(self.Password, forKey: .Password)
         try container.encode(self.Email, forKey: .Email)
         try container.encode(self.Phone, forKey: .Phone)
     }
     
     private enum CodingKeys: String, CodingKey {
         case Login = "login"
         case Password = "password"
         case Email = "email"
         case Phone = "phone"
     }
}
