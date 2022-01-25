//
//  DocumentRepository.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 21.01.2022.
//

import Foundation
import Alamofire
import Combine

class DocumentRepository {
    public func loadItem(_ documentId: Int, _ include: String) -> AnyPublisher<Document, AFError> {
        let publisher = NetworkService.getInstance().request(url: "/document", method: .get, parameters: ["documentId": documentId, "include": include]).publishDecodable(type: Document.self)
        return publisher.value();
    }
    
    public func changeStatus(documentId: Int, statusId: Int) -> AnyPublisher<Bool, AFError> {
        let publisher = NetworkService.getInstance().request(url: String(format: "/document/changestatus?documentId=%@&statusId=%@", String(documentId), String(statusId)), method: .post).publishDecodable(type: Bool.self)
        return publisher.value();
    }
}
