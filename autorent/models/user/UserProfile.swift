//
//  UserProfile.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 26.12.2021.
//

import Foundation

class UserProfile: Entity {
    var FirstName: String
    var MiddleName: String?
    var LastName: String
    var INN: String?
    var SNILS: String?
    var PassportNumber: String?
    var PassportDate: Date?
    var PassportOrg: String?
    var Email: String?
    var MobilePhone: String?
    var Addresses: [Address]
    
    override init() {
        self.FirstName = ""
        self.LastName = ""
        self.Addresses = []
        super.init()
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.FirstName = try container.decode(String.self, forKey: .FirstName)
        self.MiddleName = try container.decode(String?.self, forKey: .MiddleName)
        self.LastName = try container.decode(String.self, forKey: .LastName)
        self.INN = try container.decode(String?.self, forKey: .INN)
        self.SNILS = try container.decode(String?.self, forKey: .SNILS)
        self.PassportNumber = try container.decode(String?.self, forKey: .PassportNumber)
        let passportDate = try container.decode(String?.self, forKey: .PassportDate)
        self.PassportDate = passportDate != nil ? Utils.convertDate(value: passportDate!) : nil
        self.PassportOrg = try container.decode(String?.self, forKey: .PassportOrg)
        self.Email = try container.decode(String?.self, forKey: .Email)
        self.MobilePhone = try container.decode(String?.self, forKey: .MobilePhone)
        self.Addresses = container.contains(.Addresses) ? try container.decode([Address].self, forKey: .Addresses) : []
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case FirstName = "firstName"
        case MiddleName = "middleName"
        case LastName = "lastName"
        case INN = "inn"
        case SNILS = "snils"
        case PassportNumber = "passportNumber"
        case PassportDate = "passportDate"
        case PassportOrg = "passportOrg"
        case Email = "email"
        case MobilePhone = "mobilePhone"
        case Addresses = "addresses"
    }
    
    public func getUserName() -> String {
        let parts: [String] = [self.LastName,
                               self.FirstName,
                               self.MiddleName ?? ""]
        return parts.filter{ $0 != "" }.joined(separator: " ")
    }
}
