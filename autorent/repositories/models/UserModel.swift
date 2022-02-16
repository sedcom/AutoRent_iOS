//
//  UserModel.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 12.02.2022.
//

import Foundation

class UserModel: Codable {
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
    var AddedAddresses: [Address]
    var RemovedAddresses: [Int]
    
    init(userProfile: UserProfile) {
        self.FirstName = userProfile.FirstName
        self.MiddleName = userProfile.MiddleName
        self.LastName = userProfile.LastName
        self.INN = userProfile.INN
        self.SNILS = userProfile.SNILS
        self.PassportNumber = userProfile.PassportNumber
        self.PassportDate = userProfile.PassportDate
        self.PassportOrg = userProfile.PassportOrg
        self.Email = userProfile.Email
        self.MobilePhone = userProfile.MobilePhone
        self.AddedAddresses = []
        self.RemovedAddresses = []
    }
    
    func encode(to encoder: Encoder) throws {
         var container = encoder.container(keyedBy: CodingKeys.self)
         try container.encode(self.FirstName, forKey: .FirstName)
         try container.encode(self.MiddleName, forKey: .MiddleName)
         try container.encode(self.LastName, forKey: .LastName)
         try container.encode(self.INN, forKey: .INN)
         try container.encode(self.SNILS, forKey: .SNILS)
         try container.encode(self.PassportNumber, forKey: .PassportNumber)
         let passportDate = Utils.formatDate(format: "yyyy-MM-dd", date: self.PassportDate)
         try container.encode(passportDate, forKey: .PassportDate)
         try container.encode(self.PassportOrg, forKey: .PassportOrg)
         try container.encode(self.Email, forKey: .Email)
         try container.encode(self.MobilePhone, forKey: .MobilePhone)
         try container.encode(self.AddedAddresses, forKey: .AddedAddresses)
         try container.encode(self.RemovedAddresses, forKey: .RemovedAddresses)
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
        case AddedAddresses = "addedAddresses"
        case RemovedAddresses = "removedAddresses"
    }
}
