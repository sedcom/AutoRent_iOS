//
//  UserProfile.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 26.12.2021.
//

import Foundation

class UserProfile: Entity {
    var FirstName: String
    var MiddleName: String
    var LastName: String
    
    override init() {
        self.FirstName = ""
        self.MiddleName = ""
        self.LastName = ""
        super.init()
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.FirstName = try container.decode(String.self, forKey: .FirstName)
        self.MiddleName = try container.decode(String.self, forKey: .MidleName)
        self.LastName = try container.decode(String.self, forKey: .LastName)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case FirstName = "firstName"
        case MidleName = "middleName"
        case LastName = "lastName"
    }
}