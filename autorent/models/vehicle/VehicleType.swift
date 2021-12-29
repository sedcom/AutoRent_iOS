//
//  VehicleType.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 28.12.2021.
//

import Foundation

class VehicleType: BaseDictionary {
    var VehicleGroup: VehicleType?
    
    override init () {
        super.init()
    }
    
    init(id: Int, name: String) {
        super.init()
        self.Id = id
        self.Name = name
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.VehicleGroup = try container.decode(VehicleType?.self, forKey: .VehicleGroup)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case VehicleGroup = "vehicleGroup"
    }
}
