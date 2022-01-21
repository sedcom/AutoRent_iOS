//
//  OrderRepository.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 21.01.2022.
//

import Foundation
import Alamofire
import Combine

class OrderRepository {
    public func loadItems(_ userId: Int,_ maxItems: Int, _ skipCount: Int, _ orderBy: String, _ include: String, _ filters: String) -> AnyPublisher<Pagination<Order>, AFError> {
        let publisher = NetworkService.getInstance().request(url: "/orders", method: .get, parameters: ["userId": userId, "maxItems": maxItems, "skipCount": skipCount, "orderBy": orderBy, "include": include, "filters": filters]).publishDecodable(type: Pagination<Order>.self)
        return publisher.value();
    }
    
    public func loadItem(_ applicationId: Int, _ include: String) -> AnyPublisher<Order, AFError> {
        let publisher = NetworkService.getInstance().request(url: "/order", method: .get, parameters: ["orderId": applicationId, "include": include]).publishDecodable(type: Order.self)
        return publisher.value();
    }

}
