//
//  Document.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 21.01.2022.
//

import Foundation

class Document: Entity {
    var CreatedDate: Date?
    var Number: String?
    var Date: Date?
    var Notes: String?
    var DocumentType: autorent.DocumentType?
    var Order: autorent.Order?
    var Files: [File]
    var Invoices: [Invoice]
    var History: [DocumentHistory]
    
    override init() {
        self.Files = []
        self.Invoices = []
        self.History = []
        super.init()
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.CreatedDate = container.contains(.CreatedDate) ? Utils.convertDate(value: try container.decode(String.self, forKey: .CreatedDate)) : nil
        self.Number = container.contains(.Number) ? try container.decode(String?.self, forKey: .Number) : nil
        self.Date = container.contains(.Date) ? Utils.convertDate(value: try container.decode(String.self, forKey: .Date)) : nil
        self.Notes = container.contains(.Notes) ? try container.decode(String?.self, forKey: .Notes) : nil
        self.DocumentType = container.contains(.DocumentType) ? try container.decode(autorent.DocumentType.self, forKey: .DocumentType) : nil
        self.Order = container.contains(.Order) ? try container.decode(autorent.Order.self, forKey: .Order) : nil
        self.Files = container.contains(.Files) ? try container.decode([File].self, forKey: .Files) : []
        self.Invoices = container.contains(.Invoices) ? try container.decode([Invoice].self, forKey: .Invoices) : []
        self.History = container.contains(.History) ? try container.decode([DocumentHistory].self, forKey: .History) : []
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case CreatedDate = "createdDate"
        case Number = "number"
        case Date = "date"
        case Notes = "notes"
        case DocumentType = "documentType"
        case Order = "order"
        case Files = "files"
        case Invoices = "invoices"
        case History = "history"
    }
    
    public func getStatus () -> DocumentHistory {
        return self.History.sorted { a, b in a.Id > b.Id }.first!
    }
}
