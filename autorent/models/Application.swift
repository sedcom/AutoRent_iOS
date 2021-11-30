//
//  Application.swift
//  autorent
//
//  Created by Semyon Kravchenko on 28.11.2021.
//

import Foundation

class Application: Codable, Identifiable, Equatable {
    var Id: Int
    var CreatedDate: String
    var Notes: String
    
    enum CodingKeys: String, CodingKey {
        case Id = "id"
        case CreatedDate = "createdDate"
        case Notes = "notes"
    }
    
    static func == (lhs: Application, rhs: Application) -> Bool {
        return lhs.Id == rhs.Id
    }
}

struct ApplicationsResponse: Codable {
    var Total: Int
    var Elements: [Application]
    
    enum CodingKeys: String, CodingKey {
        case Total = "total"
        case Elements = "elements"
    }
}
