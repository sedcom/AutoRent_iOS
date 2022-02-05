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
    
    @Published var Result: Bool = false
    
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
                self.Result = true
                self.objectWillChange.send()
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                debugPrint("Finish createUser")
                self.IsLoading = false
                self.Result = result.Login != nil
        })
    }
}

