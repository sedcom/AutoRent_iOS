//
//  InvoiceViewModel.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 22.01.2022.
//

import Foundation
import Combine

class InvoiceViewModel: ObservableObject {
    var mInvoiceRepository: InvoiceRepository
    var Invoice: Invoice?
    var mEntityId: Int
    var mInclude: String
    var IsLoading: Bool = false
    var IsError: Bool = false
    var cancellation: AnyCancellable?
    @Published var ActionResult: OperationResult?
    
    init(entityId: Int, include: String) {
        self.mInvoiceRepository =  InvoiceRepository()
        self.mEntityId = entityId
        self.mInclude = include
    }
    
    public func loadData() {
        debugPrint("Start loadItem")
        self.IsLoading = true
        self.IsError = false
        self.objectWillChange.send()
        self.cancellation = self.mInvoiceRepository.loadItem(self.mEntityId, self.mInclude)
            .mapError({ (error) -> Error in
                debugPrint(error)
                self.IsError = true
                self.IsLoading = false
                self.objectWillChange.send()
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                self.Invoice = result
                self.IsLoading = false
                self.objectWillChange.send()
        })
    }
}



