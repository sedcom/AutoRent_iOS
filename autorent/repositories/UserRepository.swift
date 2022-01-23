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
        return publisher.value();
    }
}
