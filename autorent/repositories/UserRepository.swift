//
//  UserRepository.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 23.01.2022.
//

import Foundation
import Alamofire
import Combine

class UserRepository {
    public func loadItem(_ userId: Int, _ include: String) -> AnyPublisher<User, AFError> {
        let publisher = NetworkService.getInstance().request(url: "/user", method: .get, parameters: ["userId": userId, "include": include]).publishDecodable(type: User.self)
        return publisher.value()
    }
    
    public func getToken(_ model: TokenModel) -> AnyPublisher<ResultTokenModel, AFError> {
        let jsonData = try! JSONEncoder().encode(model)
        let parameters: [String: Any] = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! [String : Any]
        let publisher = NetworkService.getInstance().request(url: "/user/login", method: .post, parameters: parameters, encoding: JSONEncoding.default).publishDecodable(type: ResultTokenModel.self)
        return publisher.value()
    }
    
    public func createUser(_ model: RegistrationModel) -> AnyPublisher<User, AFError> {
        let jsonData = try! JSONEncoder().encode(model)
        let parameters: [String: Any] = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! [String : Any]
        let publisher = NetworkService.getInstance().request(url: "/user", method: .post, parameters: parameters, encoding: JSONEncoding.default).publishDecodable(type: User.self)
        return publisher.value()
    }
    
    public func activateUser(_ login: String, _ pinCode: String) -> AnyPublisher<User, AFError> {
        let publisher = NetworkService.getInstance().request(url: String(format: "/user/activate?login=%@&key=%@", login, pinCode), method: .post).publishDecodable(type: User.self)
        return publisher.value()
    }
    
    public func restorePassword(_ login: String) -> AnyPublisher<Bool, AFError> {
        let publisher = NetworkService.getInstance().request(url: String(format: "/user/restorepassword?login=%@", login), method: .post).publishDecodable(type: Bool.self)
        return publisher.value()
    }
}
