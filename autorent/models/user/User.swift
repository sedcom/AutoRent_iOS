//
//  User.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 26.12.2021.
//

import Foundation

class User: Entity {
    var Login: String
    var Profile: UserProfile
    
    override init() {
        self.Login = ""
        self.Profile = UserProfile()
        super.init()
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.Login = container.contains(.Login) ? try container.decode(String.self, forKey: .Login) : ""
        self.Profile = container.contains(.Profile) ? try container.decode(UserProfile.self, forKey: .Profile) : UserProfile()
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case Login = "login"
        case Profile = "profile"
    }
}
