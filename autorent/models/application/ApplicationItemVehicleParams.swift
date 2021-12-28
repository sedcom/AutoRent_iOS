//
//  ApplicationItemVehicleParams.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 28.12.2021.
//

import Foundation

class ApplicationItemVehicleParams: Codable {
    var VehicleType: autorent.VehicleType
    
    
    init() {
        self.VehicleType = autorent.VehicleType()
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let vehicleTypeId = try container.decode(Int.self, forKey: .VehicleType)
        self.VehicleType = autorent.VehicleType(id: vehicleTypeId, name: "")
    }
    
    private enum CodingKeys: String, CodingKey {
        case VehicleType = "VehicleTypeId"
    }
}
