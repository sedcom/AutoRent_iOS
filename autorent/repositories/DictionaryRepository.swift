//
//  DictionaryRepository.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 07.01.2022.
//

import Foundation
import Alamofire
import Combine

class DictionaryRepository {
    public func getVehicleTypes(_ orderBy: String, _ include: String) -> AnyPublisher<Pagination<VehicleType>, AFError> {
        let publisher = NetworkService.getInstance().requestGet(url: "/dictionary?type=vehicletypes", parameters: ["maxItems": 0, "skipCount": 0, "orderBy": orderBy, "include": include]).publishDecodable(type: Pagination<VehicleType>.self)
        return publisher.value();
    }
}
