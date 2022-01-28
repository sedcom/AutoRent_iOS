//
//  ResultTokenModel.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 28.01.2022.
//

import Foundation

class ResultTokenModel: Decodable {
    var Token: String?
    var UserId: Int?
    var Login: String?
    var FirstName: String?
    var MiddleName: String?
    var LastName: String?
    
    init () {
        
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.Token = container.contains(.Token) ? try container.decode(String.self, forKey: .Token) : nil
        self.UserId = container.contains(.UserId) ? try container.decode(Int.self, forKey: .UserId) : nil
        self.Login = container.contains(.Login) ? try container.decode(String.self, forKey: .Login) : nil
        self.FirstName = container.contains(.FirstName) ? try container.decode(String.self, forKey: .FirstName) : nil
        self.MiddleName = container.contains(.MiddleName) ? try container.decode(String?.self, forKey: .MiddleName) : nil
        self.LastName = container.contains(.LastName) ? try container.decode(String.self, forKey: .LastName) : nil
    }
    
    private enum CodingKeys: String, CodingKey {
        case Token = "token"
        case UserId = "userId"
        case Login = "login"
        case FirstName = "firstName"
        case MiddleName = "middleName"
        case LastName = "lastName"
    }
}
