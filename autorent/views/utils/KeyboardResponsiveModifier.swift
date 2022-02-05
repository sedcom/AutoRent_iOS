//
//  KeyboardView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 05.02.2022.
//

import SwiftUI

struct KeyboardResponsiveModifier: ViewModifier {
    @State private var offset: CGFloat = 0

    func body(content: Content) -> some View {
        content
        .padding(.bottom, offset)
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                //let value = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                //let height = value.height
                //let bottomInset = UIApplication.shared.windows.first?.safeAreaInsets.bottom
                //self.offset = height - (bottomInset ?? 0)
                self.offset = 0.1
            }
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { notification in
                self.offset = 0
            }
        }
    }
}

extension View {
    func keyboardResponsive() -> ModifiedContent<Self, KeyboardResponsiveModifier> {
        return modifier(KeyboardResponsiveModifier())
    }
}
