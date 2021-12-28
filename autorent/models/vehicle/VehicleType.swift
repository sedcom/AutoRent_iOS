//
//  VehicleType.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 28.12.2021.
//

import Foundation

class VehicleType: Entity {
    var Name: String
    
    override init() {
        self.Name = ""
        super.init()
    }
    
    init(id: Int, name: String) {
        self.Name = name
        super.init()
        self.Id = id
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.Name = try container.decode(String.self, forKey: .Name)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case Name = "name"
    }
}
