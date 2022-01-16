//
//  NetworkService.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 07.01.2022.
//

import Foundation
import Alamofire

class  NetworkService {
    private static var BASE_URL: String = "https://autorent.sedcom.ru/api"
    private static var TOKEN: String = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6ImFkbWluIiwibmFtZWlkIjoiMSIsInJvbGUiOlsiYWRtaW4iLCJkaXNwYXRjaGVyIiwic3VwcG9ydCJdLCJuYmYiOjE1OTEzNTE3MjUsImV4cCI6MTU5MTM1NTMyNSwiaWF0IjoxNTkxMzUxNzI1fQ.8u1qBGPpCrTS2SPrDHFoM6nWPLmqYYzTEkSMc3fUWng"
    
    private static var mInstance: NetworkService?
    
    public static func getInstance() -> NetworkService {
        if NetworkService.mInstance == nil {
            NetworkService.mInstance = NetworkService()
        }
        return NetworkService.mInstance!
    }
    
    public func requestGet(url: String, parameters: [String: Any]) -> DataRequest {
        return AF.request(NetworkService.BASE_URL + url, method: .get, parameters: parameters, headers: [.authorization(NetworkService.TOKEN)])
    }
    
    public func requestPost(url: String, parameters: [String: Any]) -> DataRequest {
        return AF.request(NetworkService.BASE_URL + url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: [.authorization(NetworkService.TOKEN)])
    }
    
    public func requestPut(url: String, parameters: [String: Any]) -> DataRequest {
        return AF.request(NetworkService.BASE_URL + url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: [.authorization(NetworkService.TOKEN)])
    }
}
