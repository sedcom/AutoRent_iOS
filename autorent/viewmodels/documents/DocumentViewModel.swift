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
                self.Document = result
                self.IsLoading = false
                self.objectWillChange.send()
        })
    }
}


