//
//  OrderItem.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 21.01.2022.
//

import Foundation

class OrderItem: Entity {
    var id: UUID = UUID()
    var StartDate: Date?
    var FinishDate: Date?
    var Vehicle: autorent.Vehicle
    var Hours: Int
    var Transfer: Int
    var Price: Double
    
    override init() {
        self.Vehicle = autorent.Vehicle()
        self.Hours = 0
        self.Transfer = 0
        self.Price = 0
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.StartDate = Utils.convertOffsetDate(value: try container.decode(String.self, forKey: .StartDate))
        self.FinishDate = Utils.convertOffsetDate(value: try container.decode(String.self, forKey: .FinishDate))
        self.Vehicle = try container.decode(autorent.Vehicle.self, forKey: .Vehicle)
        self.Hours = try container.decode(Int.self, forKey: .Hours)
        self.Transfer = try container.decode(Int.self, forKey: .Transfer)
        self.Price = try container.decode(Double.self, forKey: .Price)
        try super.init(from: decoder)
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case StartDate = "startDate"
        case FinishDate = "finishDate"
        case Vehicle = "vehicle"
        case Hours = "hours"
        case Transfer = "transfer"
        case Price = "price"
    }
}

