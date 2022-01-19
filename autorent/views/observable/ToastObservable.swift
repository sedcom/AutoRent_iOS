//
//  ToastObservable.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 18.01.2022.
//

import Foundation

class ToastObservable: ObservableObject {
    @Published var ShowMessage: Bool = false
    @Published var TextMessage: String = ""
}
