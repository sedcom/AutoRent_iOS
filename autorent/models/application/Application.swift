//
//  Application.swift
//  autorent
//
//  Created by Semyon Kravchenko on 28.11.2021.
//

import Foundation

class Application: Entity {
    var CreatedDate: Date?
    var User: autorent.User?
    var Company: autorent.Company?
    var Address: autorent.Address?
    var Notes: String?
    var Items: [ApplicationItem]
    var Orders: [Order]
    var History: [ApplicationHistory]
    
    override init() {
        self.Items = []
        self.Orders = []
        self.History = []
        super.init()
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.CreatedDate = container.contains(.CreatedDate) ? Utils.convertDate(value: try container.decode(String.self, forKey: .CreatedDate)) : nil
        self.User = container.contains(.User) ? try container.decode(autorent.User.self, forKey: .User) : nil
        self.Company = container.contains(.Company) ? try container.decode(autorent.Company?.self, forKey: .Company) : nil
        self.Address = container.contains(.Address) ? try container.decode(autorent.Address.self, forKey: .Address) : nil
        self.Notes = container.contains(.Notes) ? try container.decode(String.self, forKey: .Notes) : nil
        self.Items = container.contains(.Items) ? try container.decode([ApplicationItem].self, forKey: .Items) : []
        self.Orders = container.contains(.Orders) ? try container.decode([Order].self, forKey: .Orders) : []
        self.History = container.contains(.History) ? try container.decode([ApplicationHistory].self, forKey: .History) : []
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case CreatedDate = "createdDate"
        case User = "user"
        case Company = "company"
        case Address = "address"
        case Notes = "notes"
        case Items = "items"
        case Orders = "orders"
        case History = "history"
    }
    
    public func getStatus () -> ApplicationHistory {
        return self.History.sorted { a, b in a.Id > b.Id }.first!
    }
    
    public func getVehicles() -> String {
        return Set(self.Items.map { (item) -> String in return item.VehicleParams.VehicleType.getVehicleTypeName() }).joined(separator: ", ")
    }
    
    public func getDocuments() -> [Document] {
        return self.Orders.flatMap { (item) -> [Document] in return item.Documents }
    }
    
    public func getInvoices() -> [Invoice] {
        return self.Orders.flatMap { (item) -> [Invoice] in return item.getInvoices()}
    }
}
