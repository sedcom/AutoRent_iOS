//
//  ApplicationRepository.swift
//  autorent
//
//  Created by Semyon Kravchenko on 28.11.2021.
//

import Foundation
import Alamofire
import Combine

class ApplicationRepository {
    func loadItems(_ userId: Int,_ maxItems: Int, _ skipCount: Int, _ orderBy: String, _ include: String, _ filters: String) -> AnyPublisher<Pagination<Application>, AFError> {
        let publisher = NetworkService.getInstance().request(url: "/applications", method: HTTPMethod.get, parameters: ["userId": userId, "maxItems": maxItems, "skipCount": skipCount, "orderBy": orderBy, "include": include, "filters": filters]).publishDecodable(type: Pagination<Application>.self)
        return publisher.value();
    }
    
    func loadVehicleTypes(_ maxItems: Int, _ skipCount: Int, _ orderBy: String, _ include: String) -> AnyPublisher<Pagination<VehicleType>, AFError> {
        let publisher = NetworkService.getInstance().request(url: "/dictionary?type=vehicletypes", method: HTTPMethod.get, parameters: ["maxItems": maxItems, "skipCount": skipCount, "orderBy": orderBy, "include": include]).publishDecodable(type: Pagination<VehicleType>.self)
        return publisher.value();
    }
    
    func loadItem(_ applicationId: Int, _ include: String) -> AnyPublisher<Application, AFError> {
        let publisher = NetworkService.getInstance().request(url: "/application", method: HTTPMethod.get, parameters: ["applicationId": applicationId, "include": include]).publishDecodable(type: Application.self)
        return publisher.value();
    }
}
