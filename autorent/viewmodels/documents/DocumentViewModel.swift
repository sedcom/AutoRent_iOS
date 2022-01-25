//
//  DocumentViewModel.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 21.01.2022.
//

import Foundation
import Combine

class DocumentViewModel: ObservableObject {
    var mDocumentRepository: DocumentRepository
    var Document: Document?
    var mEntityId: Int
    var mInclude: String
    var IsLoading: Bool = false
    var IsError: Bool = false
    var cancellation: AnyCancellable?
    @Published var ActionResult: OperationResult?
    
    init(entityId: Int, include: String) {
        self.mDocumentRepository =  DocumentRepository()
        self.mEntityId = entityId
        self.mInclude = include
    }
    
    public func loadData() {
        debugPrint("Start loadItem")
        self.IsLoading = true
        self.IsError = false
        self.objectWillChange.send()
        self.cancellation = self.mDocumentRepository.loadItem(self.mEntityId, self.mInclude)
            .mapError({ (error) -> Error in
                debugPrint(error)
                self.IsError = true
                self.IsLoading = false
                self.objectWillChange.send()
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                debugPrint("Finish loadItem")
                self.Document = result
                //Перелинковка
                for invoice in self.Document!.Invoices {
                    invoice.Document = self.Document!
                }
                self.IsLoading = false
                self.objectWillChange.send()
        })
    }
    
    public func changeStatus(statusId: Int) {
        debugPrint("Start changeStatus")
        self.IsLoading = true
        self.objectWillChange.send()
        self.cancellation = self.mDocumentRepository.changeStatus(documentId: self.mEntityId, statusId: statusId)
            .mapError({ (error) -> Error in
                debugPrint(error)
                self.IsLoading = false
                self.ActionResult = OperationResult.Error
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                debugPrint("Finish changeStatus")
                self.IsLoading = false
                if result {
                    switch (statusId) {
                        case 3: self.ActionResult = OperationResult.Accept
                        case 4: self.ActionResult =  OperationResult.Reject
                        default: ()
                    }
                }
                else {
                    self.ActionResult = OperationResult.Error
                }
            })
    }
}
