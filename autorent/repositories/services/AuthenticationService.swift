//
//  AuthenticationService.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 28.01.2022.
//

import Foundation

class AuthenticationService {
    private static var mInstance: AuthenticationService?
    private var mToken: String?
    private var mUser: autorent.User?

    public static func getInstance() -> AuthenticationService {
        if AuthenticationService.mInstance == nil {
            AuthenticationService.mInstance = AuthenticationService()
        }
        return AuthenticationService.mInstance!
    }
    
    public func setUser(_ token: ResultTokenModel ) {
        self.mUser = autorent.User()
        self.mUser!.Id = token.UserId!
        self.mUser!.Login = token.Login!
        self.mUser!.Profile = UserProfile()
        self.mUser!.Profile.FirstName = token.FirstName!
        self.mUser!.Profile.MiddleName = token.MiddleName
        self.mUser!.Profile.LastName = token.LastName!
        self.mToken = token.Token
        
    }
    
    public func getCurrentUser() -> autorent.User? {
        return self.mUser;
    }
    
    public func getToken() -> String {
        return self.mToken ?? "";
    }
}
