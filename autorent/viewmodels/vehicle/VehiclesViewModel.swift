//
//  VehiclesViewModel.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 11.02.2022.
//

import Foundation
import Combine

class VehiclesViewModel: ObservableObject {
    var Data: Pagination<Vehicle>
    var VehicleTypes: [VehicleType]
    var cancellation: AnyCancellable?
    var mVehicleRepository: VehicleRepository
    var mUserId: Int
    var mMaxItems: Int
    var mSkipCount: Int
    var mOrderBy: String
    var mInclude: String
    var mFilter: String
    var IsLoading: Bool
    var IsError: Bool
    
    init(userId: Int, maxItems: Int, skipCount: Int, orderBy: String, include: String, filter: String) {
        self.Data = Pagination<Vehicle>()
        self.VehicleTypes = []
        self.mVehicleRepository = VehicleRepository()
        self.mUserId = userId
        self.mMaxItems = maxItems
        self.mSkipCount = skipCount
        self.mOrderBy = orderBy
        self.mInclude = include
        self.mFilter = filter
        self.IsLoading = false
        self.IsError = false
    }
    
    public func setFilter(_ filter: String) {
        self.mFilter = filter
    }
    
    public func clearData() {
        self.mSkipCount = 0
        self.Data.Elements.removeAll()
    }
    
    public func loadData() {
        debugPrint("Start loadData")
        self.IsLoading = true
        self.IsError = false
        self.Data.Elements.append(Vehicle())
        self.objectWillChange.send()
        self.cancellation = self.mVehicleRepository.loadItems(self.mUserId, self.mMaxItems, self.mSkipCount, self.mOrderBy, self.mInclude, self.mFilter)
            .mapError({ (error) -> Error in
                debugPrint(error)
                self.Data.Elements.remove(at: self.Data.Elements.count - 1)
                self.IsError = true
                self.IsLoading = false
                self.objectWillChange.send()
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                debugPrint("Finish loadData")
                self.Data.Elements.remove(at: self.Data.Elements.count - 1)
                self.Data.MaxItems = result.MaxItems
                self.Data.SkipCount = result.SkipCount
                self.Data.Total = result.Total
                self.Data.Elements.append(contentsOf: result.Elements)
                if self.VehicleTypes.count == 0 {
                    self.loadVehicleTypes()
                }
                else {
                    self.IsLoading = false
                    self.objectWillChange.send()
                }
            })
    }
    
    public func loadVehicleTypes() {
        debugPrint("Start loadData")
        self.cancellation = self.mVehicleRepository.getVehicleTypes(self.mUserId, 5)
            .mapError({ (error) -> Error in
                debugPrint(error)
                self.IsError = true
                self.IsLoading = false
                self.objectWillChange.send()
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                debugPrint("Finish loadData")
                self.VehicleTypes.append(contentsOf: result)
                self.IsLoading = false
                self.objectWillChange.send()
            })
    }
}

