//
//  ApplicationsViewModel.swift
//  autorent
//
//  Created by Semyon Kravchenko on 28.11.2021.
//

import Foundation
import Combine

class ApplicationsViewModel: ObservableObject {
    var Data: Pagination<Application>
    var cancellation: AnyCancellable?
    var mApplicationRepository: ApplicationRepository
    var mUserId: Int
    var mMaxItems: Int
    var mSkipCount: Int
    var mOrderBy: String
    var mInclude: String
    var mFilter: String
    var IsLoading: Bool
    var IsError: Bool
    
    init(userId: Int, maxItems: Int, skipCount: Int, orderBy: String, include: String, filter: String) {
        self.Data = Pagination<Application>()
        self.mApplicationRepository = ApplicationRepository()
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
        self.Data.Elements.append(Application())
        self.objectWillChange.send()
        self.cancellation = self.mApplicationRepository.loadItems(self.mUserId, self.mMaxItems, self.mSkipCount, self.mOrderBy, self.mInclude, self.mFilter)
            .mapError({ (error) -> Error in
                debugPrint(error)
                self.Data.Elements.remove(at: self.Data.Elements.count - 1)
                self.IsError = true
                self.IsLoading = false
                self.objectWillChange.send()
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                self.Data.Elements.remove(at: self.Data.Elements.count - 1)
                self.Data.MaxItems = result.MaxItems
                self.Data.SkipCount = result.SkipCount
                self.Data.Total = result.Total
                self.Data.Elements.append(contentsOf: result.Elements)
                self.loadVehicleTypes(applications: self.Data.Elements)
            })
    }
    
    private func loadVehicleTypes(applications: [Application]) {
        self.cancellation = DictionaryRepository().getVehicleTypes()
            .mapError({ (error) -> Error in
                debugPrint(error)
                self.IsError = true
                self.IsLoading = false
                self.objectWillChange.send()
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                debugPrint("Finish loadData")
                let vehicleTypes = result.Elements
                for application in applications {
                    for item in application.Items {
                        let vehicleType = vehicleTypes.first(where: { $0.Id == item.VehicleParams.VehicleType.Id })
                        item.VehicleParams.VehicleType = vehicleType!
                    }
                }
                self.IsLoading = false
                //DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
                    self.objectWillChange.send()
                //}
            })
    }
}
