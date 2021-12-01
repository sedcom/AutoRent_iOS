//
//  ButtonFilter.swift
//  autorent
//
//  Created by Semyon Kravchenko on 01.12.2021.
//

import SwiftUI

struct ButtonFilter: View {
    var label: String
    
    var body: some View {
        Button(action: {}) {
            Text(self.label)
            .foregroundColor(Color.textDark)
            .font(Font.system(size: 14))
            .padding(.all, 8)
            .frame(minWidth: 100)
        }.background(Color.primaryLight).cornerRadius(10.0)
    }
}

struct ButtonFilter_Previews: PreviewProvider {
    static var previews: some View {
        ButtonFilter(label: "Button")
    }
}
