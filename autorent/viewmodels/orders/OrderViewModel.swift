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
    
    public func updateOrderItem(item: OrderItem) {
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
                debugPrint("Finish loadItem")
                self.Order = result
                //Перелинковка
                for document in self.Order!.Documents {
                    document.Order = self.Order
                    for invoice in document.Invoices {
                        invoice.Document = document
                    }
                }
                self.IsLoading = false
                self.objectWillChange.send()
        })
    }

    public func changeStatus(statusId: Int) {
        debugPrint("Start changeStatus")
        self.IsLoading = true
        self.objectWillChange.send()
        self.cancellation = self.mOrderRepository.changeStatus(orderId: self.mEntityId, statusId: statusId)
            .mapError({ (error) -> Error in
                debugPrint(error)
                self.IsLoading = false
                self.ActionResult = OperationResult.Error
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                debugPrint("Finish changeStatus")
                self.IsLoading = false
                if result {
                    switch (statusId) {
                        case 3: self.ActionResult = OperationResult.Accept
                        case 8: self.ActionResult =  OperationResult.Reject
                        case 6: self.ActionResult =  OperationResult.Complete
                        default: ()
                    }
                }
                else {
                    self.ActionResult = OperationResult.Error
                }
            })
    }
}

