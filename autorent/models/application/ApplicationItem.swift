//
//  ApplicationItem.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 28.12.2021.
//

import Foundation

class ApplicationItem: Entity {
    var StartDate: Date?
    var FinishDate: Date?
    var VehicleParams: ApplicationItemVehicleParams
    
    override init() {
        self.VehicleParams = ApplicationItemVehicleParams()
        super.init()
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.StartDate = Utils.convertOffsetDate(value: try container.decode(String.self, forKey: .StartDate))
        self.FinishDate = Utils.convertOffsetDate(value: try container.decode(String.self, forKey: .FinishDate))
        let vehicleParams = try container.decode(String.self, forKey: .VehicleParams)
        let jsonData = vehicleParams.data(using: .utf8)
        self.VehicleParams = try JSONDecoder().decode(ApplicationItemVehicleParams.self, from: jsonData!)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case StartDate = "startDate"
        case FinishDate = "finishDate"
        case VehicleParams = "vehicleParams"
    }
}
