//
//  OrderViewModel.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 21.01.2022.
//

import Foundation
import Combine

class OrderViewModel: ObservableObject {
    var mOrderRepository: OrderRepository
    var Order: Order?
    var AddedItems: [OrderItem]
    var RemovedItems: [Int]
    var mEntityId: Int
    var mInclude: String
    var IsLoading: Bool = false
    var IsError: Bool = false
    var cancellation: AnyCancellable?
    @Published var ActionResult: OperationResult?
    
    init(entityId: Int, include: String) {
        self.mOrderRepository =  OrderRepository()
        self.AddedItems = []
        self.RemovedItems = []
        self.mEntityId = entityId
        self.mInclude = include
    }
    
    public func updateApplicationItem(item: OrderItem) {
        if (item.Id > 0) {
            var index = self.AddedItems.firstIndex { $0.id == item.id }
            if (index == nil) {
                self.AddedItems.append(item)
            }
            index = self.RemovedItems.firstIndex { $0 == item.Id }
            if (index == nil) {
                self.RemovedItems.append(item.Id)
            }
        }
        self.objectWillChange.send()
    }

    public func loadData() {
        debugPrint("Start loadItem")
        self.IsLoading = true
        self.IsError = false
        self.objectWillChange.send()
        self.cancellation = self.mOrderRepository.loadItem(self.mEntityId, self.mInclude)
            .mapError({ (error) -> Error in
                debugPrint(error)
                self.IsError = true
                self.IsLoading = false
                self.objectWillChange.send()
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                self.Order = result
                self.loadVehicleTypes(order: self.Order!)
        })
    }
    
    private func loadVehicleTypes(order: Order) {
        self.cancellation = DictionaryRepository().getVehicleTypes("Name asc", "options")
            .mapError({ (error) -> Error in
                debugPrint(error)
                self.IsError = true
                self.IsLoading = false
                self.objectWillChange.send()
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                debugPrint("Finish loadItem")
                let vehicleTypes = result.Elements
                for item in order.Application!.Items {
                    let vehicleType = vehicleTypes.first(where: { $0.Id == item.VehicleParams.VehicleType.Id })
                    item.VehicleParams.VehicleType = vehicleType!
                    var options: [ApplicationItemVehicleOption] = []
                    for option in item.VehicleParams.VehicleType.VehicleOptions {
                        var itemOption = item.VehicleParams.VehicleOptions.first(where: { $0.Id == option.Id})
                        if (itemOption == nil) {
                            itemOption = ApplicationItemVehicleOption()
                            itemOption!.Id = option.Id
                        }
                        itemOption!.VehicleOption = option
                        options.append(itemOption!)
                    }
                    item.VehicleParams.VehicleOptions = options
                }
                self.IsLoading = false
                self.objectWillChange.send()
            })
    }
}

