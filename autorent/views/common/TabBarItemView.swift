//
//  TabBarItemView.swift
//  autorent
//
//  Created by Semyon Kravchenko on 01.12.2021.
//

import SwiftUI

struct TabBarItemView: View {
    var label: String
    var image: String
    
    var body: some View {
        Image(self.image)
            .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
        Text(self.label)
    }
}
