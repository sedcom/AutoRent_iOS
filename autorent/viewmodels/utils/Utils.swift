//
//  Utils.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 26.12.2021.
//

import Foundation

class Utils {
    static func formatDate(format: String, date: Date?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return date != nil ? dateFormatter.string(from: date!) : ""
    }
    
    static func convertDate(value: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        var date = dateFormatter.date(from: value.replacingOccurrences(of: "Z", with: ""))
        if date == nil {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            date = dateFormatter.date(from: value.replacingOccurrences(of: "Z", with: ""))
        }
        return date!
    }
    
    static func convertOffsetDate(value: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return dateFormatter.date(from: value)!
    }
}
