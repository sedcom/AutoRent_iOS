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
    let url = "https://autorent.sedcom.ru/api"
    let token = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6ImFkbWluIiwibmFtZWlkIjoiMSIsInJvbGUiOlsiYWRtaW4iLCJkaXNwYXRjaGVyIiwic3VwcG9ydCJdLCJuYmYiOjE1OTEzNTE3MjUsImV4cCI6MTU5MTM1NTMyNSwiaWF0IjoxNTkxMzUxNzI1fQ.8u1qBGPpCrTS2SPrDHFoM6nWPLmqYYzTEkSMc3fUWng"

    func loadItems(_ maxItems: Int, _ skipCount: Int) -> AnyPublisher<ApplicationsResponse, AFError> {
        let headers: HTTPHeaders = [
            .authorization(self.token)
        ]
        let publisher = AF.request(self.url + "/applications", method: HTTPMethod.get, parameters: ["maxItems": maxItems, "skipCount": skipCount], headers: headers).publishDecodable(type: ApplicationsResponse.self);
        return publisher.value();
    }
    
    func loadItem(_ applicationId: Int, _ include: String) -> AnyPublisher<Application, AFError> {
        let headers: HTTPHeaders = [
            .authorization(self.token)
        ]
        let publisher = AF.request(self.url + "/application", method: HTTPMethod.get, parameters: ["applicationId": applicationId, "include": include], headers: headers).publishDecodable(type: Application.self);
        return publisher.value();
    }}
