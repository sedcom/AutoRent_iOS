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
    
    override init() {
        self.CreatedDate = Date()
        self.User = autorent.User()
        self.Address = autorent.Address()
        self.Notes = ""
        self.Items = []
        super.init()
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.CreatedDate = Utils.convertDate(value: try container.decode(String.self, forKey: .CreatedDate))
        self.User = try container.decode(autorent.User.self, forKey: .User)
        self.Address = try container.decode(autorent.Address.self, forKey: .Address)
        self.Notes = try container.decode(String.self, forKey: .Notes)
        self.Items = try container.decode([ApplicationItem].self, forKey: .Items)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case CreatedDate = "createdDate"
        case User = "user"
        case Address = "address"
        case Notes = "notes"
        case Items = "items"
    }
    
    
    public func getVehicles() -> String {
        self.Items.map { (item) -> String in return item.VehicleParams.VehicleType.Name }.joined(separator: ", ")
    }
}
