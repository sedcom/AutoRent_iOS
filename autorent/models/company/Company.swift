//
//  Company.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 20.01.2022.
//

import Foundation

class Company: Entity {
    var CompanyType: autorent.CompanyType?
    var OwnershipType: autorent.OwnershipType?
    var Name: String?
    var FirstName: String?
    var MiddleName: String?
    var LastName: String?
    var INN: String?
    var KPP: String?
    var Email: String?
    var MobilePhone: String?
    var Addresses: [Address]
    
    override init() {
        self.Addresses = []
        super.init()
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.CompanyType = container.contains(.CompanyType) ? try container.decode(autorent.CompanyType.self, forKey: .CompanyType): nil
        self.OwnershipType = container.contains(.OwnershipType) ? try container.decode(autorent.OwnershipType.self, forKey: .OwnershipType) : nil
        self.Name = container.contains(.Name) ? try container.decode(String?.self, forKey: .Name) : nil
        self.FirstName = container.contains(.FirstName) ? try container.decode(String?.self, forKey: .FirstName) : nil
        self.MiddleName = container.contains(.MiddleName) ? try container.decode(String?.self, forKey: .MiddleName) : nil
        self.LastName = container.contains(.LastName) ? try container.decode(String?.self, forKey: .LastName) : nil
        self.INN = container.contains(.INN) ? try container.decode(String?.self, forKey: .INN) : nil
        self.KPP = container.contains(.KPP) ? try container.decode(String?.self, forKey: .KPP) : nil
        self.Email = container.contains(.Email) ? try container.decode(String?.self, forKey: .Email) : nil
        self.MobilePhone = container.contains(.MobilePhone) ? try container.decode(String?.self, forKey: .MobilePhone) : nil
        self.Addresses = container.contains(.Addresses) ? try container.decode([Address].self, forKey: .Addresses) : []
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case CompanyType = "companyType"
        case OwnershipType = "ownershipType"
        case Name = "name"
        case FirstName = "firstName"
        case MiddleName = "middleName"
        case LastName = "lastName"
        case INN = "inn"
        case KPP = "kpp"
        case Email = "email"
        case MobilePhone = "mobilePhone"
        case Addresses = "addresses"
    }
    
    public func getCompanyName() -> String {
        let parts: [String] = [self.LastName ?? "",
                               self.FirstName ?? "",
                               self.MiddleName ?? ""]
        return self.CompanyType!.Id == 1 ? String(format: "%@ %@", self.OwnershipType!.Name, self.Name!) : parts.filter{ $0 != "" }.joined(separator: " ")
    }
}
