//
//  CompanyViewModel.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 16.02.2022.
//

import Foundation
import Combine

class CompanyViewModel: ObservableObject {
    var mCompanyRepository: CompanyRepository
    var Company: Company?
    var mEntityId: Int
    var mInclude: String
    var IsLoading: Bool = false
    var IsError: Bool = false
    var cancellation: AnyCancellable?
    @Published var ActionResult: OperationResult?
    
    init(entityId: Int, include: String) {
        self.mCompanyRepository =  CompanyRepository()
        self.mEntityId = entityId
        self.mInclude = include
    }
    
    public func createItem() {
        let company = autorent.Company()
        self.Company = company
        self.objectWillChange.send()
    }
    
    public func loadData() {
        debugPrint("Start loadItem")
        self.IsLoading = true
        self.IsError = false
        self.objectWillChange.send()
        self.cancellation = self.mCompanyRepository.loadItem(self.mEntityId, self.mInclude)
            .mapError({ (error) -> Error in
                debugPrint(error)
                self.IsError = true
                self.IsLoading = false
                self.objectWillChange.send()
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                self.Company = result
                self.IsLoading = false
                self.objectWillChange.send()
        })
    }

    public func saveItem(statusId: Int? = nil) {
        
    }
}
