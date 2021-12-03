//
//  ButtonFilterStyle.swift
//  autorent
//
//  Created by Semyon Kravchenko on 01.12.2021.
//

import SwiftUI

struct FilterButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 100)
            .padding(.all, 6)
            .background(Color.primaryLight)
            .cornerRadius(10)
            .foregroundColor(Color.textDark)
    }
}
