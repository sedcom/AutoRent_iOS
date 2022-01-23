//
//  InvoiceItem.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 23.01.2022.
//

import Foundation

class InvoiceItem: Entity {
    var id: UUID = UUID()
    var Name: String
    var Summa: Double
    var Tax: Double
    
    override init() {
        self.Name = ""
        self.Summa = 0
        self.Tax = 0
        super.init()
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.Name = try container.decode(String.self, forKey: .Name)
        self.Summa = try container.decode(Double.self, forKey: .Summa)
        self.Tax = try container.decode(Double.self, forKey: .Tax)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case Name = "name"
        case Summa = "summa"
        case Tax = "tax"
    }
}
