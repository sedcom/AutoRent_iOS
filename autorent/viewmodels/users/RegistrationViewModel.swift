//
//  RegistrationViewModel.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 05.02.2022.
//

import Foundation
import Combine

class RegistrationViewModel: ObservableObject {
    var mUserRepository: UserRepository
    var RegistrationModel: autorent.RegistrationModel
    var IsLoading: Bool = false
    var IsError: Bool = false
    var cancellation: AnyCancellable?
    @Published var ActionResult: Int?
    
    init() {
        self.mUserRepository =  UserRepository()
        self.RegistrationModel = autorent.RegistrationModel()
    }
    
    public func createUser () -> Void {
        debugPrint("Start createUser")
        self.IsLoading = true
        self.IsError = false
        self.objectWillChange.send()
        self.cancellation = self.mUserRepository.createUser(self.RegistrationModel)
            .mapError({ (error) -> Error in
                debugPrint(error)
                self.IsError = true
                self.IsLoading = false
                self.objectWillChange.send()
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                debugPrint("Finish createUser")
                self.IsLoading = false
                self.ActionResult = 1
        })
    }
    
    public func activateUser (pinCode: String) -> Void {
        debugPrint("Start activateUser")
        self.IsLoading = true
        self.IsError = false
        self.objectWillChange.send()
        self.cancellation = self.mUserRepository.activateUser(self.RegistrationModel.Login, pinCode)
            .mapError({ (error) -> Error in
                debugPrint(error)
                self.IsError = true
                self.IsLoading = false
                self.objectWillChange.send()
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                debugPrint("Finish activateUser")
                self.IsLoading = false
                self.ActionResult = 2
        })
    }
}

