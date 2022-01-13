//
//  CustomTabItem.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 13.01.2022.
//

import Foundation

class CustomTabItem {
    public var Index: Int
    public var Label: String
    public var Image: String
    public var Disabled: Bool
    
    init(index: Int, label: String, image: String, disabled: Bool = false) {
        self.Index = index
        self.Label = label
        self.Image = image
        self.Disabled = disabled
    }
}
