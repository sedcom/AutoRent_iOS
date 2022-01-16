//
//  ToastView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 13.01.2022.
//

import SwiftUI
import Combine

struct ToastView: View  {
    @Binding var Visible: Bool
    var mText: String
    
    init(text: String, visible: Binding<Bool>) {
        self.mText = text
        self._Visible = visible
    }
    
    var body: some View {
        if self.Visible {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
                self.Visible = false
                print("Toast hide...")
            }
        }
        
        return GeometryReader { geo in
            ZStack {
                VStack {
                    Text(self.mText)
                }
                .frame(width: geo.size.width, height: 50)
                .background(Color.textDark)
                .foregroundColor(Color.textLight)
                .cornerRadius(4)
                .opacity(self.Visible ? 1 : 0)
                .transition(.slide)
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .bottom)
        }
    }
}

