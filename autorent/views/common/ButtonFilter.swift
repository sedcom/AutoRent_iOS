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
                .font(Font.system(size: 14))
                .foregroundColor(Color.textDark)
                .frame(minWidth: 100)
                .padding(.all, 8)
                
        }
        .background(Color.primaryLight).cornerRadius(10.0)
    }
}

struct ButtonFilter_Previews: PreviewProvider {
    static var previews: some View {
        ButtonFilter(label: "Button")
    }
}
