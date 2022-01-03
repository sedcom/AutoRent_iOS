//
//  VehicleType.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 28.12.2021.
//

import Foundation

class VehicleType: BaseDictionary {
    var VehicleGroup: VehicleType?
    var VehicleOptions: [VehicleOption]
    
    override init () {
        self.VehicleOptions = []
        super.init()
    }
    
    override init (id: Int, name: String) {
        self.VehicleOptions = []
        super.init(id: id, name: name)
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.VehicleGroup = try container.decode(VehicleType?.self, forKey: .VehicleGroup)
        self.VehicleOptions = try container.decode([VehicleOption].self, forKey: .VehicleOptions)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case VehicleGroup = "vehicleGroup"
        case VehicleOptions = "vehicleOptions"
    }
    
    public func getVehicleTypeName() -> String {
        return self.VehicleGroup != nil ? String(format: "%@ / %@", self.VehicleGroup!.Name, self.Name) : self.Name
    }
}
