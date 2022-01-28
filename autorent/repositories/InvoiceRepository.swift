//
//  InvoiceRepository.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 22.01.2022.
//

import Foundation
import Alamofire
import Combine

class InvoiceRepository {
    public func loadItems(_ userId: Int,_ maxItems: Int, _ skipCount: Int, _ orderBy: String, _ include: String, _ filters: String) -> AnyPublisher<Pagination<Invoice>, AFError> {
        let publisher = NetworkService.getInstance().request(url: "/invoices", method: .get, parameters: ["userId": userId, "maxItems": maxItems, "skipCount": skipCount, "orderBy": orderBy, "include": include, "filters": filters]).publishDecodable(type: Pagination<Invoice>.self)
        return publisher.value();
    }
    
    public func loadItem(_ invoiceId: Int, _ include: String) -> AnyPublisher<Invoice, AFError> {
        let publisher = NetworkService.getInstance().request(url: "/invoice", method: .get, parameters: ["invoiceId": invoiceId, "include": include]).publishDecodable(type: Invoice.self)
        return publisher.value();
    }
    
    public func changeStatus(invoiceId: Int, statusId: Int) -> AnyPublisher<Bool, AFError> {
        let publisher = NetworkService.getInstance().request(url: String(format: "/invoice/changestatus?invoiceId=%@&statusId=%@", String(invoiceId), String(statusId)), method: .post).publishDecodable(type: Bool.self)
        return publisher.value();
    }
}
