//
//  ApplicationModel.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 08.01.2022.
//

import Foundation

class ApplicationModel : Codable {
    var CompanyId: Int?
    var Address: autorent.Address
    var Notes: String
    var AddedItems: [ApplicationItem]
    var RemovedItems: [Int]
    
    init(application: Application) {
        self.CompanyId = application.Company != nil ? application.Company!.Id : nil
        self.Address = application.Address
        self.Notes = application.Notes
        self.AddedItems = []
        self.RemovedItems = []
    }
    
   func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.CompanyId, forKey: .CompanyId)
        try container.encode(self.Address, forKey: .Address)
        try container.encode(self.Notes, forKey: .Notes)
        try container.encode(self.AddedItems, forKey: .AddedItems)
        try container.encode(self.RemovedItems, forKey: .RemovedItems)
    }
    
    private enum CodingKeys: String, CodingKey {
        case CompanyId = "companyId"
        case Address = "address"
        case Notes = "notes"
        case AddedItems = "addedItems"
        case RemovedItems = "removedItems"
    }
}
