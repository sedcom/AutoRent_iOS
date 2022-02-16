//
//  ApplicationViewModel.swift
//  autorent
//
//  Created by Semyon Kravchenko on 29.11.2021.
//

import Foundation
import Combine

class ApplicationViewModel: ObservableObject {
    var mApplicationRepository: ApplicationRepository
    var Application: Application?
    var AddedItems: [ApplicationItem]
    var RemovedItems: [Int]
    var mEntityId: Int
    var mInclude: String
    var IsLoading: Bool = false
    var IsError: Bool = false
    var cancellation: AnyCancellable?
    @Published var ActionResult: OperationResult?
    
    init(entityId: Int, include: String) {
        self.mApplicationRepository =  ApplicationRepository()
        self.AddedItems = []
        self.RemovedItems = []
        self.mEntityId = entityId
        self.mInclude = include        
    }

    public func createItem(address: Address? = nil) {
        let application = autorent.Application()
        application.User = AuthenticationService.getInstance().getCurrentUser()
        application.Address = address ?? Address()
        application.Address!.AddressType = AddressType(id: 3, name: "")
        let item = ApplicationItem()
        //item.StartDate = Date()
        //item.FinishDate = Date()
        //item.VehicleParams.VehicleType = VehicleType(id: 901, name: "Vehicle")
        application.Items.append(item)
        //application.Notes = "Test application from mobile iOS"
        self.Application = application
        self.AddedItems.append(item)
        self.objectWillChange.send()
    }
    
    public func addApplicationItem() {
        let item = ApplicationItem()
        self.Application!.Items.append(item)
        self.AddedItems.append(item)
        self.objectWillChange.send()
    }
    
    public func updateApplicationItem(item: ApplicationItem) {
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
    
    public func removeApplicationItems(items: [UUID]) {
        items.forEach { uuid in
            var index = self.Application!.Items.firstIndex { $0.id == uuid }
            if (index != nil) {
                let item = self.Application!.Items[index!]
                self.Application!.Items.remove(at: index!)
                if (item.Id > 0) {
                    self.RemovedItems.append(item.Id)
                }
            }
            index = self.AddedItems.firstIndex { $0.id == uuid }
            if (index != nil) {
                self.AddedItems.remove(at: index!)
            }
        }
    }
    
    public func loadData() {
        debugPrint("Start loadItem")
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
        self.cancellation = DictionaryRepository().getVehicleTypes("Id asc", "options")
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
                //Перелинковка
                for order in application.Orders {
                    order.Application = application
                    for document in order.Documents {
                        document.Order = order
                        for invoice in document.Invoices {
                            invoice.Document = document
                        }
                    }
                }
                self.IsLoading = false
                self.objectWillChange.send()
            })
    }
    
    public func saveItem(statusId: Int? = nil) {
        debugPrint("Start saveItem")
        self.IsLoading = true
        self.objectWillChange.send()
        let model = ApplicationModel(application: self.Application!)
        model.AddedItems = self.AddedItems
        model.RemovedItems = self.RemovedItems
        if self.Application!.Id == 0 {
            self.createItem(model: model, statusId: statusId)
        }
        else {
            self.updateItem(applicationId: self.Application!.Id, model: model, statusId: statusId)
        }
    }
    
    private func createItem(model: ApplicationModel, statusId: Int? = nil) {
        self.cancellation = self.mApplicationRepository.createItem(application: model)
            .mapError({ (error) -> Error in
                debugPrint(error)
                self.IsLoading = false
                self.ActionResult = OperationResult.Error
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                debugPrint("Finish saveItem")
                self.mEntityId = result.Id
                self.Application!.Id = result.Id
                if (statusId != nil) {
                    self.changeStatus(statusId: statusId!)
                }
                else {
                    self.IsLoading = false
                    self.ActionResult = OperationResult.Create
                }
        })
    }
    
    private func updateItem(applicationId: Int, model: ApplicationModel, statusId: Int? = nil) {
        self.cancellation = self.mApplicationRepository.updateItem(applicationId: applicationId, application: model)
            .mapError({ (error) -> Error in
                debugPrint(error)
                self.IsLoading = false
                self.ActionResult = OperationResult.Error
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                debugPrint("Finish saveItem")
                if (statusId != nil) {
                    self.changeStatus(statusId: statusId!)
                }
                else {
                    self.IsLoading = false
                    self.ActionResult = OperationResult.Update
                }
        })
    }
    
    public func changeStatus(statusId: Int) {
        debugPrint("Start changeStatus")
        self.IsLoading = true
        self.objectWillChange.send()
        self.cancellation = self.mApplicationRepository.changeStatus(applicationId: self.mEntityId, statusId: statusId)
            .mapError({ (error) -> Error in
                debugPrint(error)
                self.IsLoading = false
                self.ActionResult = OperationResult.Error
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                debugPrint("Finish changeStatus")
                self.IsLoading = false
                self.ActionResult = result ? OperationResult.Send : OperationResult.Error
            })
    }
}
