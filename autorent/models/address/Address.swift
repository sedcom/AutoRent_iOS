//
//  Address.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 27.12.2021.
//

import Foundation

class Address: Entity {
    var AddressType: AddressType
    var PostIndex: String?
    var Region: AddressRegion?
    var District: AddressDistrict?
    var City: AddressCity?
    var Street: AddressStreet?
    var House: String?
    
    override init() {
        self.AddressType = autorent.AddressType()
        super.init()
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.AddressType = try container.decode(autorent.AddressType.self, forKey: .AddressType)
        self.PostIndex = try container.decode(String?.self, forKey: .PostIndex)
        self.Region = try container.decode(AddressRegion?.self, forKey: .Region)
        self.District = try container.decode(AddressDistrict?.self, forKey: .District)
        self.City = try container.decode(AddressCity?.self, forKey: .City)
        self.Street = try container.decode(AddressStreet?.self, forKey: .Street)
        self.House = try container.decode(String?.self, forKey: .House)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.AddressType.Id, forKey: .AddressTypeId)
        try container.encode(self.PostIndex, forKey: .PostIndex)
        try container.encode(self.Region, forKey: .Region)
        try container.encode(self.District, forKey: .District)
        try container.encode(self.City, forKey: .City)
        try container.encode(self.Street, forKey: .Street)
        try container.encode(self.House, forKey: .House)
        try super.encode(to: encoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case AddressTypeId = "addressTypeId"
        case AddressType = "addressType"
        case PostIndex = "postIndex"
        case Region = "region"
        case District = "district"
        case City = "city"
        case Street = "street"
        case House = "house"
    }
    
    public func getAddressName() -> String {
        let parts: [String] = [self.PostIndex ?? "",
                               self.Region != nil ? self.Region!.Name ?? "" : "",
                               self.District != nil ?  self.District!.Name ?? "" : "",
                               self.City != nil ?  self.City!.Name ?? "" : "",
                               self.Street != nil ?  self.Street!.Name ??  "" : "",
                               self.House ?? ""]
        return parts.filter { $0 != "" }.joined(separator: ", ")
    }
}
