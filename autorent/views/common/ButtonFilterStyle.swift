//
//  ButtonFilterStyle.swift
//  autorent
//
//  Created by Semyon Kravchenko on 01.12.2021.
//

import SwiftUI

struct FilterButtonStyle: ButtonStyle {
    var mSelected: Bool
    
    init(selected: Bool) {
        self.mSelected = selected
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 100)
            .padding(.all, 6)
            .background(self.mSelected ? Color.primary : Color.primaryLight)
            .cornerRadius(10)
            .foregroundColor(self.mSelected ? Color.textLight : Color.textDark)
    }
}
