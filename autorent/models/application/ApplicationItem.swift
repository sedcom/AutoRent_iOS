//
//  ApplicationItem.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 28.12.2021.
//

import Foundation

class ApplicationItem: Entity {
    var id: UUID = UUID()
    var StartDate: Date?
    var FinishDate: Date?
    var VehicleParams: ApplicationItemVehicleParams
    
    override init() {
        self.VehicleParams = ApplicationItemVehicleParams()
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.StartDate = Utils.convertOffsetDate(value: try container.decode(String.self, forKey: .StartDate))
        self.FinishDate = Utils.convertOffsetDate(value: try container.decode(String.self, forKey: .FinishDate))
        let vehicleParams = try container.decode(String.self, forKey: .VehicleParams)
        let jsonData = vehicleParams.data(using: .utf8)
        self.VehicleParams = try JSONDecoder().decode(ApplicationItemVehicleParams.self, from: jsonData!)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let startDate = Utils.formatDate(format: "yyyy-MM-dd'T'HH:mm:ssZZZZZ", date: self.StartDate)
        try container.encode(startDate, forKey: .StartDate)
        let finishDate = Utils.formatDate(format: "yyyy-MM-dd'T'HH:mm:ssZZZZZ", date: self.FinishDate)
        try container.encode(finishDate, forKey: .FinishDate)
        let jsonData = try JSONEncoder().encode(self.VehicleParams)
        let vehicleParams = String(data: jsonData, encoding: .utf8)
        try container.encode(vehicleParams, forKey: .VehicleParams)
        try super.encode(to: encoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case StartDate = "startDate"
        case FinishDate = "finishDate"
        case VehicleParams = "vehicleParams"
    }
}
