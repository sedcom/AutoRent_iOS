//
//  AuthenticationViewModel.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 28.01.2022.
//

import Foundation
import Combine

class AuthenticationViewModel: ObservableObject {
    var mUserRepository: UserRepository
    var IsLoading: Bool = false
    var IsError: Bool = false
    var cancellation: AnyCancellable?
    @Published var Result: Bool?
    
    init() {
        self.mUserRepository =  UserRepository()
    }
    
    public func authenticateUser (login: String, password: String) -> Void {
        debugPrint("Start autenticateUser")
        self.IsLoading = true
        self.IsError = false
        self.objectWillChange.send()
        let model = TokenModel(login: login, password: password)
        self.cancellation = self.mUserRepository.getToken(model)
            .mapError({ (error) -> Error in
                debugPrint(error)
                self.IsError = true
                self.IsLoading = false
                self.objectWillChange.send()
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                debugPrint("Finish autenticateUser")
                self.Result = result.Token != nil
                if (result.Token != nil) {
                    AuthenticationService.getInstance().setUser(result)
                }
                self.IsLoading = false
        })
    }
}
