//
//  File.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 23.01.2022.
//

import Foundation

class File: Entity {
    var Name: String
    var Content: [UInt8]
    
    override init() {
        self.Name = ""
        self.Content = []
        super.init()
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.Name = try container.decode(String.self, forKey: .Name)
        let contentString = try container.decode(String.self, forKey: .Content)
        let contentData = Data(base64Encoded: contentString)
        self.Content = [UInt8](contentData!)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case Name = "name"
        case Content = "content"
    }
}
