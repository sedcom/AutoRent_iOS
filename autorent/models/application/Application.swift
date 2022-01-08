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
    var Address: autorent.Address
    var Notes: String
    var Items: [ApplicationItem]
    var History: [ApplicationHistory]
    
    
    override init() {
        self.CreatedDate = Date()
        self.User = autorent.User()
        self.Address = autorent.Address()
        self.Notes = ""
        self.Items = []
        self.History = []
        super.init()
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.CreatedDate = Utils.convertDate(value: try container.decode(String.self, forKey: .CreatedDate))
        self.User = try container.decode(autorent.User.self, forKey: .User)
        self.Address = try container.decode(autorent.Address.self, forKey: .Address)
        self.Notes = try container.decode(String.self, forKey: .Notes)
        self.Items = []
        if container.contains(.Items) {
            self.Items = try container.decode([ApplicationItem].self, forKey: .Items)
        }
        self.History = []
        if container.contains(.History) {
            self.History = try container.decode([ApplicationHistory].self, forKey: .History)
        }
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.Address, forKey: .Address)
        try container.encode(self.Notes, forKey: .Notes)
        try container.encode(self.Items, forKey: .AddedItems)
        try super.encode(to: encoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case CreatedDate = "createdDate"
        case User = "user"
        case Address = "address"
        case Notes = "notes"
        case Items = "items"
        case AddedItems = "addedItems"
        case History = "history"
    }
    
    public func getStatus () -> String {
        return self.History.sorted {a, b in a.Id < b.Id }.first!.Status.Name
    }
    
    public func getVehicles() -> String {
        return Set(self.Items.map { (item) -> String in return item.VehicleParams.VehicleType.getVehicleTypeName() }).joined(separator: ", ")
    }
}
