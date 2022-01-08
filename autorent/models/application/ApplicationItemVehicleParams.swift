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
        self.VehicleOptions = container.contains(.VehicleOptions) ? try container.decode([ApplicationItemVehicleOption].self, forKey: .VehicleOptions) : []
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.VehicleType.Id, forKey: .VehicleType)
    }
    
    private enum CodingKeys: String, CodingKey {
        case VehicleType = "VehicleTypeId"
        case VehicleOptions = "VehicleOptions"
    }
}
