//
//  VehicleOptionType.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 02.01.2022.
//

import Foundation

class VehicleOptionType: BaseDictionary {
    var ValueType: String
    var ValueParams: String?
    
    override init () {
        self.ValueType = ""
        super.init()
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.ValueType = try container.decode(String.self, forKey: .ValueType)
        self.ValueParams = try container.decode(String?.self, forKey: .ValueParams)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case ValueType = "valueType"
        case ValueParams = "valueParams"
    }
}
