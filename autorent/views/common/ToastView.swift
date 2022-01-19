//
//  ToastView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 18.01.2022.
//

import SwiftUI

struct ToastView: View {
    @Binding var Message: String?
    
    init(_ message: Binding<String?>) {
        self._Message = message
    }

    var body: some View {
        if self.Message != nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
                self.Message = nil
                print("Toast hide...")
            }
        }
        
        return GeometryReader { geo in
            ZStack {
                VStack {
                    Text(self.Message ?? "" )
                }
                .frame(width: geo.size.width, height: 50)
                .background(Color.textDark)
                .foregroundColor(Color.textLight)
                .cornerRadius(4)
                .opacity(self.Message != nil ? 1 : 0)
                .transition(.slide)
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .bottom)
        }
    }
}


