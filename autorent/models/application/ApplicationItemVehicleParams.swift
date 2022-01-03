//
//  ApplicationItemVehicleParams.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 28.12.2021.
//

import Foundation

class ApplicationItemVehicleParams: Codable {
    var VehicleType: autorent.VehicleType
    var VehicleOptions: [ApplicationItemVehicleOption]
    
    init() {
        self.VehicleType = autorent.VehicleType()
        self.VehicleOptions = []
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let vehicleTypeId = try container.decode(Int.self, forKey: .VehicleType)
        self.VehicleType = autorent.VehicleType(id: vehicleTypeId, name: "")
        self.VehicleOptions = try container.decode([ApplicationItemVehicleOption].self, forKey: .VehicleOptions)
    }
    
    private enum CodingKeys: String, CodingKey {
        case VehicleType = "VehicleTypeId"
        case VehicleOptions = "VehicleOptions"
    }
}
