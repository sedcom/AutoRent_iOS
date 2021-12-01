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
    
    private enum CodingKeys: String, CodingKey {
        case Id = "id"
    }
    
    static func == (lhs: Entity, rhs: Entity) -> Bool {
        return lhs.Id == rhs.Id
    }
}
