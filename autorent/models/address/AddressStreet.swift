//
//  AddressStreet.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 27.12.2021.
//

import Foundation

class AddressStreet: Codable {
    var Name: String?
    
    init() {
        
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.Name = try container.decode(String?.self, forKey: .Name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.Name, forKey: .Name)
    }
    
    private enum CodingKeys: String, CodingKey {
        case Name = "name"
    }
}
