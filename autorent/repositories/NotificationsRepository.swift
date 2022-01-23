//
//  NotificationsRepository.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 23.01.2022.
//

import Foundation
import Alamofire
import Combine

class NotificationsRepository {
    public func loadItems(_ userId: Int,_ maxItems: Int, _ skipCount: Int, _ orderBy: String, _ include: String, _ filters: String) -> AnyPublisher<Pagination<UserNotification>, AFError> {
        let publisher = NetworkService.getInstance().request(url: "/notifications", method: .get, parameters: ["userId": userId, "maxItems": maxItems, "skipCount": skipCount, "orderBy": orderBy, "include": include, "filters": filters]).publishDecodable(type: Pagination<UserNotification>.self)
        return publisher.value();
    }
}
