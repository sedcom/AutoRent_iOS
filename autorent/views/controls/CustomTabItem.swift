//
//  CustomTabItem.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 13.01.2022.
//

import Foundation

class CustomTabItem {
    var Index: Int
    var Label: String
    var Image: String
    var Disabled: Bool
    
    init(index: Int, label: String, image: String, disabled: Bool = false) {
        self.Index = index
        self.Label = label
        self.Image = image
        self.Disabled = disabled
    }
}
