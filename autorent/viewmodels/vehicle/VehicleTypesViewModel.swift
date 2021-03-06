//
//  VehicleTypesViewModel.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 07.01.2022.
//

import Foundation
import Combine

class VehicleTypesViewModel: ObservableObject {
    var Data: Pagination<VehicleType>
    var cancellation: AnyCancellable?
    var mDictionaryRepository: DictionaryRepository
    var mOrderBy: String
    var mInclude: String
    var IsLoading: Bool
    var IsError: Bool
    
    init(orderBy: String, include: String) {
        self.Data = Pagination<VehicleType>()
        self.mDictionaryRepository = DictionaryRepository()
        self.mOrderBy = orderBy
        self.mInclude = include
        self.IsLoading = false
        self.IsError = false
    }
    
    public func clearData() {
        self.Data.Elements.removeAll()
    }
    
    public func loadData() {
        debugPrint("Start loadData")
        self.IsLoading = true
        self.IsError = false
        self.cancellation = self.mDictionaryRepository.getVehicleTypes(self.mOrderBy, self.mInclude)
            .mapError({ (error) -> Error in
                debugPrint(error)
                self.IsLoading = false
                self.IsError = true
                self.objectWillChange.send()
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                debugPrint("Finish loadData")
                self.Data.MaxItems = result.MaxItems
                self.Data.SkipCount = result.SkipCount
                self.Data.Total = result.Total
                self.Data.Elements.append(contentsOf: result.Elements)
                self.IsLoading = false
                self.objectWillChange.send()
            })
    }
}
