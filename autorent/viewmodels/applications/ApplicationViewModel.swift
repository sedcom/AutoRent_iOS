//
//  ApplicationViewModel.swift
//  autorent
//
//  Created by Semyon Kravchenko on 29.11.2021.
//

import Foundation
import Combine
import SwiftUI

class ApplicationViewModel: ObservableObject {
    var Application: Application?
    var cancellation: AnyCancellable?
    var mApplicationRepository: ApplicationRepository = ApplicationRepository()
    @Binding var mEntityId: Int
    var mInclude: String
    var IsLoading: Bool
    var IsError: Bool
    @Published var saveResult: Int = 0
    
    init(entityId: Binding<Int>, include: String) {
        self._mEntityId = entityId
        self.mInclude = include
        self.IsLoading = false
        self.IsError = false
    }

    public func createItem() {
        let application = autorent.Application()
        application.User = User()
        application.Address = Address()
        application.Address.AddressTypeId = 3
        let item = ApplicationItem()
        application.Items.append(item)
        item.StartDate = Date()
        item.FinishDate = Date()
        item.VehicleParams.VehicleType = VehicleType(id: 901, name: "Some vehicle")
        application.Notes = "Test iOS"
        self.Application = application
        self.objectWillChange.send()
    }
    
    public func addApplicationItem() {
        let item = ApplicationItem()
        self.Application!.Items.append(item)
        self.objectWillChange.send()
    }
    
    public func removeApplicationItems(items: [UUID]) {
        items.forEach { uuid in
            let index = self.Application!.Items.firstIndex { $0.id == uuid }!
            self.Application!.Items.remove(at: index)
        }
    }
    
    public func loadData() {
        debugPrint("Start loadData")
        self.IsLoading = true
        self.IsError = false
        self.objectWillChange.send()
        self.cancellation = self.mApplicationRepository.loadItem(self.mEntityId, self.mInclude)
            .mapError({ (error) -> Error in
                debugPrint(error)
                self.IsError = true
                self.IsLoading = false
                self.objectWillChange.send()
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                self.Application = result
                self.loadVehicleTypes(application: self.Application!)
        })
    }
    
    private func loadVehicleTypes(application: Application) {
        self.cancellation = DictionaryRepository().getVehicleTypes("Name asc", "options")
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
                self.IsLoading = false
                self.objectWillChange.send()
            })
    }
    
    public func saveItem() {
        debugPrint("Start saveData")
        self.IsLoading = true
        self.objectWillChange.send()
        var model = ApplicationModel(application: self.Application!)
        model.AddedItems = self.Application!.Items
        self.cancellation = self.mApplicationRepository.createItem(application: model)
            .mapError({ (error) -> Error in
                debugPrint(error)
                self.IsLoading = false
                self.saveResult = 3
                //self.objectWillChange.send()
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                debugPrint("Finish saveData")
                self.IsLoading = false
                self.Application!.Id = result.Id
                self.saveResult = 2
                //self.objectWillChange.send()
        })
    }    
}
