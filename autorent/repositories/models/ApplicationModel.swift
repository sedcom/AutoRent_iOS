//
//  ApplicationModel.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 08.01.2022.
//

import Foundation

class ApplicationModel {
    var CompanyId: Int?
    var Address: autorent.Address
    var Notes: String
    var AddedItems: [ApplicationItem]
    
    init() {
        self.Address = autorent.Address()
        self.Notes = ""
        self.AddedItems = []        
    }
}
