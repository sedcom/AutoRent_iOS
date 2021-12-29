//
//  BaseHistory.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 28.12.2021.
//

import Foundation

class BaseHistory: Entity {
    var CreatedDate: Date
    var Status: BaseStatus
    
    override init() {
        self.CreatedDate = Date()
        self.Status = BaseStatus()
        super.init()
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.CreatedDate = Utils.convertDate(value: try container.decode(String.self, forKey: .CreatedDate))
        self.Status = try container.decode(BaseStatus.self, forKey: .Status)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case CreatedDate = "createdDate"
        case Status = "status"
    }
}
