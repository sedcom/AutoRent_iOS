//
//  Pagination.swift
//  autorent
//
//  Created by Semyon Kravchenko on 01.12.2021.
//

import Foundation

class Pagination<T: Entity>: Codable {
    var MaxItems: Int
    var SkipCount: Int
    var Total: Int
    var Elements: [T]
    
    init() {
        self.MaxItems = 0
        self.SkipCount = 0
        self.Total = 0
        self.Elements = []
    }
    
    private enum CodingKeys: String, CodingKey {
        case MaxItems = "maxItems"
        case SkipCount = "skipCount"
        case Total = "total"
        case Elements = "elements"
    }
}
