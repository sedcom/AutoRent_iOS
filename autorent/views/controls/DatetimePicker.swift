//
//  DatetimePicker.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 06.01.2022.
//

import SwiftUI

struct DatetimePicker: View {
    @Binding var showDatePicker: Bool
    @Binding var selectedDate: Date
    @State var currentDate: Date = Date()
    
    var body: some View {
        ZStack {}
        .frame(minWidth: 0, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(Color.primaryDark)
        .opacity(0.8)
        
        VStack {
            DatePicker("", selection: $currentDate)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding(EdgeInsets(top: 8, leading: 8, bottom: 0, trailing: 8))
                .background(Color.white)
            HStack {
                Button("button_ok", action: {
                    showDatePicker = false
                    selectedDate = currentDate
                })
                Button("button_cancel", action: {
                    showDatePicker = false
                })
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .font(Font.headline.weight(.bold))
            .padding(.all, 8)
            .background(Color.white)
        }
        .accentColor(Color.secondary)
        .background(Color.white)
        .frame(width: 300)
    }
}

