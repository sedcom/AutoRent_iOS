//
//  AddressObservable.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 18.01.2022.
//

import Foundation

class AddressObservable: ObservableObject, Equatable {
    @Published public var Address: autorent.Address?
    
    static func == (lhs: AddressObservable, rhs: AddressObservable) -> Bool {
        return false
    }
}
