//
//  ApplicationItemEditView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 06.01.2022.
//

import SwiftUI

struct ApplicationItemEditView: View {
    @Binding var showDatePicker: Bool
    @Binding var datePicker: Date
    var mApplicationItem: ApplicationItem
    var mIndex: Int
    @State var mNotes: String = ""
    @State var mDate: Int = 1
    @State var showAlert: Bool = false
    
    init(applicationItem: ApplicationItem, index: Int, showDatePicker: Binding<Bool>, datePicker: Binding<Date>) {
        self.mApplicationItem = applicationItem
        self.mIndex = index
        _showDatePicker = showDatePicker
        _datePicker = datePicker
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
                                .onChange(of:  $datePicker.wrappedValue, perform: { value in
                                    if self.mDate == 1 {
                                        self.mApplicationItem.StartDate = value
                                    }
                                })
                             Text(Utils.formatDate(format: "HH:mm ZZZZZ", date: self.mApplicationItem.StartDate))
                                .foregroundColor(Color.textDark)
                                .font(Font.headline.weight(.bold))
                         }
                     }
                     .padding(.all, 8)
                     .frame(minWidth: 0, maxWidth: .infinity)
                     .background(Color.inputBackgroud)
                     .cornerRadius(4)
                     .onTapGesture {
                        self.mDate = 1
                        self.showDatePicker.toggle()
                        self.datePicker = self.mApplicationItem.FinishDate
                     }
                     HStack {
                         Image("calendar-alt")
                             .renderingMode(.template)
                             .resizable()
                             .foregroundColor(Color.textDark)
                             .frame(width: 30, height: 35)
                         VStack {
                             Text(Utils.formatDate(format: "dd MMMM yyyy", date: self.mApplicationItem.FinishDate))
                                .foregroundColor(Color.textDark)
                                .onChange(of:  $datePicker.wrappedValue, perform: { value in
                                    if self.mDate == 2 {
                                        self.mApplicationItem.FinishDate = value
                                    }
                                })
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
                        self.mDate = 2
                        self.showDatePicker.toggle()
                        self.datePicker = self.mApplicationItem.FinishDate
                     }
                 }
                 VStack {
                    Text("Тип автотранспорта")
                        .foregroundColor(Color.textLight)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("", text: Binding(
                                get: { self.mApplicationItem.VehicleParams.VehicleType.getVehicleTypeName() },
                                set: { _ in }))
                        .frame(minHeight: 30, maxHeight: 30)
                        .background(Color.inputBackgroud)
                        .cornerRadius(4)
                        .disabled(true)
                        .onTapGesture {
                          showAlert = true
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("123"), message: Text("321"), dismissButton: .none)
                        }
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


