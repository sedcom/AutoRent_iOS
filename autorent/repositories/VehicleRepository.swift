//
//  VehicleRepository.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 11.02.2022.
//

import Foundation
import Alamofire
import Combine

class VehicleRepository {
    public func loadItems(_ userId: Int,_ maxItems: Int, _ skipCount: Int, _ orderBy: String, _ include: String, _ filters: String) -> AnyPublisher<Pagination<Vehicle>, AFError> {
        let publisher = NetworkService.getInstance().request(url: "/vehicles", method: .get, parameters: ["userId": userId, "maxItems": maxItems, "skipCount": skipCount, "orderBy": orderBy, "include": include, "filters": filters]).publishDecodable(type: Pagination<Vehicle>.self)
        return publisher.value();
    }
}
