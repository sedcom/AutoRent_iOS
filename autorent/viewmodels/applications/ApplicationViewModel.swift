//
//  ApplicationViewModel.swift
//  autorent
//
//  Created by Semyon Kravchenko on 29.11.2021.
//

import Foundation
import Combine

class ApplicationViewModel: ObservableObject {
    var Application: Application?
    var cancellation: AnyCancellable?
    var mApplicationRepository: ApplicationRepository = ApplicationRepository()
    var mEntityId: Int
    var mInclude: String
    var IsLoading: Bool
    var IsError: Bool
    
    init(entityId: Int, include: String) {
        self.mEntityId = entityId
        self.mInclude = include
        self.IsLoading = false
        self.IsError = false
    }

    public func createItem() {
        self.Application = autorent.Application()
        self.Application!.User = User()
        self.Application!.Address = Address()
        self.Application!.Items.append(ApplicationItem())
        self.objectWillChange.send()
    }
    
    public func loadData() {
        debugPrint("Start loadData")
        self.IsLoading = true
        self.IsError = false
        self.objectWillChange.send()
        self.cancellation = self.mApplicationRepository.loadItem(self.mEntityId, self.mInclude)
            .mapError({ (error) -> Error in
                debugPrint(error)
                self.IsLoading = false
                self.IsError = true
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                debugPrint("Finish loadData")
                self.IsLoading = false
                self.Application = result
                self.loadVehicleTypes(application: self.Application!)
        })
    }
    
    private func loadVehicleTypes(application: Application) {
        self.cancellation = self.mApplicationRepository.loadVehicleTypes(0, 0, "", "options")
            .mapError({ (error) -> Error in
                debugPrint(error)
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                let vehicleTypes = result.Elements
                for item in application.Items {
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
                //DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                    self.objectWillChange.send()
                //}
            })
    }
    
    
}
