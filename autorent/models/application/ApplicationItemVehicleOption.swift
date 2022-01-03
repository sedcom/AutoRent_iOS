//
//  ApplicationItemVehicleOption.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 02.01.2022.
//

import Foundation

class ApplicationItemVehicleOption: Codable, Identifiable {
    var Id: Int
    var ValueBoolean: Bool?
    var ValueDate: Date?
    var ValueDecimal: Decimal?
    var ValueInt: Int?
    var ValueString: String?
    var VehicleOption: autorent.VehicleOption
    
    init() {
        self.Id = 0
        self.VehicleOption = autorent.VehicleOption()
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.Id = try container.decode(Int.self, forKey: .Id)
        self.ValueBoolean = container.contains(.ValueBoolean) ? try container.decode(Bool.self, forKey: .ValueBoolean) : nil
        self.ValueDate = container.contains(.ValueDate) ? try container.decode(Date.self, forKey: .ValueDate) : nil
        self.ValueDecimal = container.contains(.ValueDecimal) ? try container.decode(Decimal.self, forKey: .ValueDecimal) : nil
        self.ValueInt = container.contains(.ValueInt) ? try container.decode(Int.self, forKey: .ValueInt) : nil
        self.ValueString = container.contains(.ValueString) ? try container.decode(String.self, forKey: .ValueString) : nil
        self.VehicleOption = autorent.VehicleOption()
    }
    
    private enum CodingKeys: String, CodingKey {
        case Id = "Id"
        case ValueBoolean = "ValueBoolean"
        case ValueDate = "ValueDate"
        case ValueDecimal =  "ValueDecimal"
        case ValueInt = "ValueInt"
        case ValueString = "ValueString"
    }
}
