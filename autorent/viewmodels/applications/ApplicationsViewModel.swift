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
    var mMaxItems: Int
    var mSkipCount: Int
    var mOrderBy: String
    var mInclude: String
    var mFilter: String
    var IsLoading: Bool
    var IsError: Bool
    
    init(maxItems: Int, skipCount: Int, orderBy: String, include: String, filter: String) {
        self.Data = Pagination<Application>()
        self.mApplicationRepository = ApplicationRepository()
        self.mMaxItems = maxItems
        self.mSkipCount = skipCount
        self.mOrderBy = orderBy
        self.mInclude = include
        self.mFilter = filter
        self.IsLoading = false
        self.IsError = false
    }
    
    func setFilter(_ filter: String) {
        self.mFilter = filter
    }
    
    func clearData() {
        self.mSkipCount = 0
        self.Data.Elements.removeAll()
    }
    
    func loadData() {
        debugPrint("Start loadData")
        self.IsLoading = true
        self.IsError = false
        self.Data.Elements.append(Application())
        self.objectWillChange.send()
        self.cancellation = self.mApplicationRepository.loadItems(self.mMaxItems, self.mSkipCount, self.mOrderBy, self.mInclude, self.mFilter)
            .mapError({ (error) -> Error in
                debugPrint(error)
                self.Data.Elements.remove(at: self.Data.Elements.count - 1)
                self.IsLoading = false
                self.IsError = true
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
                self.IsLoading = false
                self.loadVehicleTypes(applications: self.Data.Elements)
            })
    }
    
    private func loadVehicleTypes(applications: [Application]) {
        self.cancellation = self.mApplicationRepository.loadVehicleTypes(0, 0, "", "options")
            .mapError({ (error) -> Error in
                debugPrint(error)
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                let vehicleTypes = result.Elements
                for application in applications {
                    for item in application.Items {
                        let vehicleType = vehicleTypes.first(where: { $0.Id == item.VehicleParams.VehicleType.Id })
                        item.VehicleParams.VehicleType = vehicleType!
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                    self.objectWillChange.send()
                }
            })
    }
}
