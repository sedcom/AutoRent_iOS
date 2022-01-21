//
//  CustomTextField.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 21.01.2022.
//

import SwiftUI

struct CustomTextField: View {
    let mText: Binding<String>
    let mDisabled: Bool
    
    init(_ text: Binding<String>, disabled: Bool = false) {
        self.mText = text
        self.mDisabled = disabled
    }
    
    var body: some View {
        TextField("", text: self.mText)
            .frame(minHeight: 30, maxHeight: 30)
            .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
            .background(Color.inputBackgroud)
            .foregroundColor(Color.textDark)
            .cornerRadius(4)
            .disabled(self.mDisabled)
    }
}
