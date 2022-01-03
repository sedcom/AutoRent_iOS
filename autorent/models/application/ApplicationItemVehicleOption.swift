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
    
    public func getOptionValue() -> String? {
        switch self.VehicleOption.VehicleOptionType.ValueType {
            case "bool":
                return (self.ValueBoolean != nil) ? (self.ValueBoolean!) ? "+" : "-" : nil
            case "int":
                return (self.ValueInt != nil) ? String(self.ValueInt!) : nil
            case "string":
                return self.ValueString
            case "list":
                let jsonData = self.VehicleOption.VehicleOptionType.ValueParams!.data(using: .utf8)
                let params = try! JSONDecoder().decode([String: String].self, from: jsonData!)
                return params.first(where: { $0.key == String(self.ValueInt!) })!.value
            default:
                return nil
        }
    }
}

