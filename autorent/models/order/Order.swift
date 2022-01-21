//
//  Order.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 21.01.2022.
//

import Foundation

class Order: Entity {
    var CreatedDate: Date?
    var Company: autorent.Company?
    var Application: autorent.Application?
    var Items: [OrderItem]
    var History: [OrderHistory]
    
    override init() {
        self.Items = []
        self.History = []
        super.init()
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.CreatedDate = container.contains(.CreatedDate) ? Utils.convertDate(value: try container.decode(String.self, forKey: .CreatedDate)) : nil
        self.Company = container.contains(.Company) ? try container.decode(autorent.Company.self, forKey: .Company) : nil
        self.Application = container.contains(.Application) ? try container.decode(autorent.Application.self, forKey: .Application) : nil
        self.Items = container.contains(.Items) ? try container.decode([OrderItem].self, forKey: .Items) : []
        self.History = container.contains(.History) ? try container.decode([OrderHistory].self, forKey: .History) : []
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case CreatedDate = "createdDate"
        case Company = "company"
        case Application = "application"
        case Notes = "notes"
        case Items = "items"
        case History = "history"
    }
    
    public func getStatus () -> OrderHistory {
        return self.History.sorted { a, b in a.Id > b.Id }.first!
    }
}

