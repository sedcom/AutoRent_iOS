//
//  Vehicle.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 21.01.2022.
//

import Foundation

class Vehicle: Entity {
    var RegNumber: String?
    var Producer: String?
    var Model: String?
    var Year: Int?
    var VehicleType: autorent.VehicleType?
    
    override init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.RegNumber = container.contains(.RegNumber) ? try container.decode(String.self, forKey: .RegNumber) : nil
        self.Producer = container.contains(.Producer) ? try container.decode(String.self, forKey: .Producer) : nil
        self.Model = container.contains(.Model) ? try container.decode(String.self, forKey: .Model) : nil
        self.Year = container.contains(.Year) ? try container.decode(Int.self, forKey: .Year) : nil
        self.VehicleType = container.contains(.VehicleType) ? try container.decode(autorent.VehicleType.self, forKey: .VehicleType) : nil
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case RegNumber = "regNumber"
        case VehicleType = "vehicleType"
        case Producer = "producer"
        case Model = "model"
        case Year = "year"
    }
}
