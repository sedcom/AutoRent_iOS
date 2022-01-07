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

    /*public func getVehicleGroups () -> [VehicleType] {
        var types: [VehicleType] = []
        self.Data.Elements.filter { $0.VehicleGroup == nil }.forEach {
            let vehicleType = $0
            if types.first(where: { $0.Id == vehicleType.Id }) == nil {
                types.append(vehicleType)
            }
        }
        return types
    }*/
    
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
                //DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                    self.objectWillChange.send()
                //}
            })
    }
}
