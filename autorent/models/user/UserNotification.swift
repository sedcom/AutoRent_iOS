//
//  UserNotification.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 23.01.2022.
//

import Foundation

class UserNotification: Entity {
    var CreatedDate: Date
    var Message: String
    var Marked: Bool
    
    
    override init() {
        self.CreatedDate = Date()
        self.Message = ""
        self.Marked = false
        super.init()
    }
    
    required init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.CreatedDate = Utils.convertDate(value: try container.decode(String.self, forKey: .CreatedDate))
        self.Message = try container.decode(String.self, forKey: .Message)
        self.Marked = try container.decode(Bool.self, forKey: .Marked)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case CreatedDate = "createdDate"
        case Message = "message"
        case Marked = "marked"
    }
    
    public func formatMessage() -> String {
        let regex = try! NSRegularExpression(pattern: "<a.*?>|</a>", options: .caseInsensitive)
        return regex.stringByReplacingMatches(in: self.Message, options: .withTransparentBounds, range: NSMakeRange(0, self.Message.count), withTemplate: "")
    }
}
