//
//  ApplicationItemEditView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 06.01.2022.
//

import SwiftUI

struct ApplicationItemEditView: View {
    @Binding var showDatePicker: Bool
    var mApplicationItem: ApplicationItem
    var mIndex: Int
    @State var mNotes: String = ""
    @State var mDate: Date = Date()
    
    
    init(applicationItem: ApplicationItem, index: Int, showDatePicker: Binding<Bool>) {
        self.mApplicationItem = applicationItem
        self.mIndex = index
        _showDatePicker = showDatePicker
    }
    
    var body: some View {
        VStack {
             VStack {
                Text("Position #\(self.mIndex)")
                     .foregroundColor(Color.textLight)
                     .font(Font.headline.weight(.bold))
                     .frame(maxWidth: .infinity, alignment: .trailing)
                 HStack {
                     HStack {
                         Image("calendar-alt")
                             .renderingMode(.template)
                             .resizable()
                            .foregroundColor(Color.textDark)
                             .frame(width: 30, height: 35)
                         VStack {
                            Text(Utils.formatDate(format: "dd MMMM yyyy", date: self.mApplicationItem.StartDate))
                                 .foregroundColor(Color.textDark)
                             Text(Utils.formatDate(format: "HH:mm ZZZZZ", date: self.mApplicationItem.StartDate))
                                 .foregroundColor(Color.textDark)
                                 .font(Font.headline.weight(.bold))
                         }
                     }
                     .padding(.all, 8)
                     .frame(minWidth: 0, maxWidth: .infinity)
                     .background(Color.inputBackgroud)
                     .cornerRadius(4)
                     HStack {
                         Image("calendar-alt")
                             .renderingMode(.template)
                             .resizable()
                             .foregroundColor(Color.textDark)
                             .frame(width: 30, height: 35)
                         VStack {
                             Text(Utils.formatDate(format: "dd MMMM yyyy", date: self.mApplicationItem.FinishDate))
                                 .foregroundColor(Color.textDark)
                             Text(Utils.formatDate(format: "HH:mm ZZZZZ", date: self.mApplicationItem.FinishDate))
                                 .foregroundColor(Color.textDark)
                                 .font(Font.headline.weight(.bold))
                         }
                     }
                     .padding(.all, 8)
                     .frame(minWidth: 0, maxWidth: .infinity)
                     .background(Color.inputBackgroud)
                     .cornerRadius(4)
                     .onTapGesture {
                        self.showDatePicker.toggle()
                     }
                 }
                 VStack {
                    Text("Тип автотранспорта")
                        .foregroundColor(Color.textLight)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("", text: $mNotes)
                        .frame(minHeight: 30, maxHeight: 30)
                        .background(Color.inputBackgroud)
                        .cornerRadius(4)
                 }
                 ForEach(self.mApplicationItem.VehicleParams.VehicleOptions) { option in
                     if option.getOptionValue() != nil {
                         HStack {
                             Image("iconmonstr-gear")
                                 .renderingMode(.template)
                                 .foregroundColor(Color.textLight)
                             Text(option.VehicleOption.VehicleOptionType.Name)
                                 .foregroundColor(Color.textLight)
                                 .fixedSize(horizontal: false, vertical: true)
                                 .frame(maxWidth: .infinity, alignment: .leading)
                             Text(option.getOptionValue()!)
                                 .foregroundColor(Color.textLight)
                                 .font(Font.headline.weight(.bold))
                                 .fixedSize(horizontal: false, vertical: true)
                                 .frame(maxWidth: .infinity, alignment: .leading)
                         }
                     }
                 }
             }
             .padding(.all, 12)
         }
         .frame(minWidth: 0, maxWidth: .infinity)
         .background(Color.primaryDark)
         .cornerRadius(5)
    }
}
