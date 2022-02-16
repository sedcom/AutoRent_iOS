//
//  UserProfileViewModel.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 23.01.2022.
//

import Foundation
import Combine

class UserProfileViewModel: ObservableObject {
    var mUserRepository: UserRepository
    var User: User?
    var AddedAddresses: [Address]
    var RemovedAddresses: [Int]
    var mEntityId: Int
    var mInclude: String
    var IsLoading: Bool = false
    var IsError: Bool = false
    var cancellation: AnyCancellable?
    @Published var ActionResult: OperationResult?
    
    init(entityId: Int, include: String) {
        self.mUserRepository =  UserRepository()
        self.AddedAddresses = []
        self.RemovedAddresses = []
        self.mEntityId = entityId
        self.mInclude = include
    }
    
    public func loadData() {
        debugPrint("Start loadItem")
        self.IsLoading = true
        self.IsError = false
        self.objectWillChange.send()
        self.cancellation = self.mUserRepository.loadItem(self.mEntityId, self.mInclude)
            .mapError({ (error) -> Error in
                debugPrint(error)
                self.IsError = true
                self.IsLoading = false
                self.objectWillChange.send()
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                debugPrint("Finish loadItem")
                self.User = result
                self.IsLoading = false
                self.objectWillChange.send()
        })
    }
    
    public func saveItem() {
        debugPrint("Start saveItem")
        self.IsLoading = true
        self.objectWillChange.send()
        let model = UserModel(userProfile: self.User!.Profile)
        model.AddedAddresses = self.AddedAddresses
        model.RemovedAddresses = self.RemovedAddresses
        self.cancellation = self.mUserRepository.updateUser(userId: self.mEntityId, user: model)
            .mapError({ (error) -> Error in
                debugPrint(error)
                self.IsLoading = false
                self.ActionResult = OperationResult.Error
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                debugPrint("Finish saveItem")
                self.User = result
                self.IsLoading = false
                self.ActionResult = OperationResult.Update
        })
    }
}

