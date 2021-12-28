//
//  AddressDistrict.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 27.12.2021.
//

import Foundation

class AddressDistrict: Codable {
    var Name: String
    
    init() {
        self.Name = ""
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.Name = try container.decode(String.self, forKey: .Name)
    }
    
    private enum CodingKeys: String, CodingKey {
        case Name = "name"
    }
}
