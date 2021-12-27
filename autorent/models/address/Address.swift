//
//  Address.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 27.12.2021.
//

import Foundation

class Address: Entity {
    var PostIndex: String?
    var Region: AddressRegion?
    var District: AddressDistrict?
    var City: AddressCity?
    var Street: AddressStreet?
    var House: String?
    
    override init() {
        self.PostIndex = ""
        self.Region = AddressRegion()
        self.District = AddressDistrict()
        self.City = AddressCity()
        self.Street = AddressStreet()
        self.House = ""
        super.init()
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.PostIndex = try container.decode(String?.self, forKey: .PostIndex)
        self.Region = try container.decode(AddressRegion?.self, forKey: .Region)
        self.District = try container.decode(AddressDistrict?.self, forKey: .District)
        self.City = try container.decode(AddressCity?.self, forKey: .City)
        self.Street = try container.decode(AddressStreet?.self, forKey: .Street)
        self.House = try container.decode(String?.self, forKey: .House)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case PostIndex = "postIndex"
        case Region = "region"
        case District = "district"
        case City = "city"
        case Street = "Street"
        case House = "house"
    }
    
    public func getAddressName() -> String {
        let parts: [String] = [self.PostIndex != nil ? self.PostIndex! : "",
                               self.Region != nil ? self.Region!.Name : "",
                               self.District != nil ? self.District!.Name : "",
                               self.City != nil ? self.City!.Name : "",
                               self.Street != nil ? self.Street!.Name : "",
                               self.House != nil ? self.House! : ""]
        return parts.filter{ $0 != "" }.joined(separator: ", ")
    }
}
