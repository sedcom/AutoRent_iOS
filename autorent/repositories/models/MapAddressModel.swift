//
//  MapAddressModel.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 19.01.2022.
//

import Foundation

class MapAddressModel: Decodable {
    var PostCode: String?
    var State: String?
    var County: String?
    var City: String?
    var Town: String?
    var Village: String?
    var Road: String?
    var HouseNumber: String?
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.PostCode = container.contains(.PostCode) ? try container.decode(String?.self, forKey: .PostCode) : nil
        self.State = container.contains(.State) ?  try container.decode(String?.self, forKey: .State) : nil
        self.County = container.contains(.County) ?  try container.decode(String?.self, forKey: .County) : nil
        self.City = container.contains(.City) ?  try container.decode(String?.self, forKey: .City) : nil
        self.Town = container.contains(.Town) ?  try container.decode(String?.self, forKey: .Town) : nil
        self.Village = container.contains(.Village) ?  try container.decode(String?.self, forKey: .Village) : nil
        self.Road = container.contains(.Road) ?  try container.decode(String?.self, forKey: .Road) : nil
        self.HouseNumber = container.contains(.HouseNumber) ?  try container.decode(String?.self, forKey: .HouseNumber) : nil
    }
    
    public func convertToAddress() -> autorent.Address {
        let address = autorent.Address()
        address.PostIndex = self.PostCode
        address.Region = self.State != nil ? AddressRegion(name: self.State!) : nil
        address.District = self.County != nil ? AddressDistrict(name: self.County!) : nil
        address.City =  self.City != nil ? AddressCity(name: self.City!) :
                        self.Town != nil ? AddressCity(name: self.Town!) :
                        self.Village != nil ? AddressCity(name: self.Village!) : nil
        address.Street = self.Road != nil ? AddressStreet(name: self.Road!) : nil
        address.House = self.HouseNumber
        return address
    }
    
    private enum CodingKeys: String, CodingKey {
        case PostCode = "postcode"
        case State = "state"
        case County = "county"
        case City = "city"
        case Town = "town"
        case Village = "village"
        case Road = "road"
        case HouseNumber = "house_number"
    }
}
