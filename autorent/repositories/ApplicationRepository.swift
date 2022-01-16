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
    public func loadItems(_ userId: Int,_ maxItems: Int, _ skipCount: Int, _ orderBy: String, _ include: String, _ filters: String) -> AnyPublisher<Pagination<Application>, AFError> {
        let publisher = NetworkService.getInstance().requestGet(url: "/applications", parameters: ["userId": userId, "maxItems": maxItems, "skipCount": skipCount, "orderBy": orderBy, "include": include, "filters": filters]).publishDecodable(type: Pagination<Application>.self)
        return publisher.value();
    }
    
    public func loadItem(_ applicationId: Int, _ include: String) -> AnyPublisher<Application, AFError> {
        let publisher = NetworkService.getInstance().requestGet(url: "/application", parameters: ["applicationId": applicationId, "include": include]).publishDecodable(type: Application.self)
        return publisher.value();
    }
    
    public func createItem(application: ApplicationModel) -> AnyPublisher<Application, AFError> {
        let jsonData = try! JSONEncoder().encode(application)
        let parameters: [String: Any] = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! [String : Any]
        let publisher = NetworkService.getInstance().requestPost(url: "/application", parameters: parameters).publishDecodable(type: Application.self)
        return publisher.value();
    }
    
    public func updateItem(applicationId: Int, application: ApplicationModel) -> AnyPublisher<Application, AFError> {
        let jsonData = try! JSONEncoder().encode(application)
        var parameters: [String: Any] = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! [String : Any]
        let publisher = NetworkService.getInstance().requestPut(url: String(format: "/application?applicationId=%@", String(applicationId)), parameters: parameters).publishDecodable(type: Application.self)
        return publisher.value();
    }
}
