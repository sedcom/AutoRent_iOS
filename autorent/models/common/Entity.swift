//
//  Entity.swift
//  autorent
//
//  Created by Semyon Kravchenko on 30.11.2021.
//

import Foundation

class Entity: Codable, Identifiable, Equatable {
    var Id: Int
    
    init() {
        self.Id = 0
    }
    
    init(id: Int) {
        self.Id = id
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.Id = try container.decode(Int.self, forKey: .Id)
    }
    
    private enum CodingKeys: String, CodingKey {
        case Id = "id"
    }
    
    static func == (lhs: Entity, rhs: Entity) -> Bool {
        return lhs.Id == rhs.Id
    }
}
