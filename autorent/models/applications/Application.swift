//
//  Application.swift
//  autorent
//
//  Created by Semyon Kravchenko on 28.11.2021.
//

import Foundation

class Application: Entity {
    var CreatedDate: Date
    var User: autorent.User
    var Notes: String
    
    override init() {
        self.CreatedDate = Date()
        self.User = autorent.User()
        self.Notes = ""
        super.init()
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dateString = try container.decode(String.self, forKey: .CreatedDate)
        self.CreatedDate = Utils.convertDate(value: dateString)
        self.User = try container.decode(autorent.User.self, forKey: .User)
        self.Notes = try container.decode(String.self, forKey: .Notes)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case CreatedDate = "createdDate"
        case User = "user"
        case Notes = "notes"
    }
}
