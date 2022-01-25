//
//  StatusObservable.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 25.01.2022.
//

import Foundation

class StatusObservable: ObservableObject {
    @Published public var Status: autorent.BaseStatus?
}
