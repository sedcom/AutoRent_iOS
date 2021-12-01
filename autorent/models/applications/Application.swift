//
//  Application.swift
//  autorent
//
//  Created by Semyon Kravchenko on 28.11.2021.
//

import Foundation

class Application: Entity {
    var CreatedDate: String
    var Notes: String
    
    override init() {
        self.CreatedDate = ""
        self.Notes = ""
        super.init()
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.CreatedDate = try container.decode(String.self, forKey: .CreatedDate)
        self.Notes = try container.decode(String.self, forKey: .Notes)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case CreatedDate = "createdDate"
        case Notes = "notes"
    }
}
