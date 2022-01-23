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
    var mEntityId: Int
    var mInclude: String
    var IsLoading: Bool = false
    var IsError: Bool = false
    var cancellation: AnyCancellable?
    @Published var ActionResult: OperationResult?
    
    init(entityId: Int, include: String) {
        self.mUserRepository =  UserRepository()
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
}

