//
//  VehicleOption.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 02.01.2022.
//

import Foundation

class VehicleOption: Entity {
    var VehicleOptionType: autorent.VehicleOptionType
    
    override init () {
        self.VehicleOptionType = autorent.VehicleOptionType()
        super.init()
    }
    

    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.VehicleOptionType = try container.decode(autorent.VehicleOptionType.self, forKey: .VehicleOptionType)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case VehicleOptionType = "vehicleOptionType"
    }
}
