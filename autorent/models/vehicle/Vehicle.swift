//
//  Vehicle.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 21.01.2022.
//

import Foundation

class Vehicle: Entity {
    var RegNumber: String?
    
    override init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.RegNumber = try container.decode(String?.self, forKey: .RegNumber)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case RegNumber = "regNumber"
    }
}
