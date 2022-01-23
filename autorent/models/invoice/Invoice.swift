//
//  Invoice.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 21.01.2022.
//

import Foundation

class Invoice: Entity {
    var CreatedDate: Date?
    var Number: String?
    var Date: Date?
    var Notes: String?
    var InvoiceType: autorent.InvoiceType?
    var Items: [InvoiceItem]
    var Document: autorent.Document?
    var History: [InvoiceHistory]
    
    override init() {
        self.Items = []
        self.History = []
        super.init()
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.CreatedDate = container.contains(.CreatedDate) ? Utils.convertDate(value: try container.decode(String.self, forKey: .CreatedDate)) : nil
        self.Number = container.contains(.Number) ? try container.decode(String?.self, forKey: .Number) : nil
        self.Date = container.contains(.Date) ? Utils.convertDate(value: try container.decode(String.self, forKey: .Date)) : nil
        self.Notes = container.contains(.Notes) ? try container.decode(String?.self, forKey: .Notes) : nil
        self.InvoiceType = container.contains(.InvoiceType) ? try container.decode(autorent.InvoiceType.self, forKey: .InvoiceType) : nil
        self.Document = container.contains(.Document) ? try container.decode(autorent.Document.self, forKey: .Document) : nil
        self.Items = container.contains(.Items) ? try container.decode([InvoiceItem].self, forKey: .Items) : []
        self.History = container.contains(.History) ? try container.decode([InvoiceHistory].self, forKey: .History) : []
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case CreatedDate = "createdDate"
        case Number = "number"
        case Date = "date"
        case Notes = "notes"
        case InvoiceType = "invoiceType"
        case Document = "document"
        case Items = "items"
        case History = "history"
    }
    
    public func getStatus () -> InvoiceHistory {
        return self.History.sorted { a, b in a.Id > b.Id }.first!
    }
}
