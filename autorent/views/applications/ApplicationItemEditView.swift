//
//  ApplicationItemEditView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 06.01.2022.
//

import SwiftUI

struct ApplicationItemEditView: View {
    @ObservedObject var mViewModel : ApplicationViewModel
    var mCurrentMode: ModeView
    var mIndex: Int
    @Binding var showDatePicker: Bool
    @Binding var selectedDate: Date
    @State var mDatePickerIndex: Int = 0
    @State var mSelectedVehicleType: VehicleType = VehicleType()
    
    init(viewModel: ApplicationViewModel, mode: ModeView, index: Int, showDatePicker: Binding<Bool>, selectedDate: Binding<Date>) {
        self.mViewModel = viewModel
        self.mCurrentMode = mode
        self.mIndex = index
        self._showDatePicker = showDatePicker
        self._selectedDate = selectedDate
    }
    
    var body: some View {
        VStack {
             VStack {
                Text("Position #\(self.mIndex + 1)")
                     .frame(maxWidth: .infinity, alignment: .trailing)
                     .foregroundColor(Color.textLight)
                     .font(Font.headline.weight(.bold))
                 HStack {
                     HStack {
                         Image("calendar-alt")
                             .renderingMode(.template)
                             .resizable()
                             .frame(width: 30, height: 35)
                             .foregroundColor(Color.textDark)
                         VStack {                            
                            Text(Utils.formatDate(format: "dd MMMM yyyy", date: self.mViewModel.Application!.Items[self.mIndex].StartDate))
                                .foregroundColor(Color.textDark)
                                .onChange(of:  $selectedDate.wrappedValue, perform: { value in
                                    if self.mDatePickerIndex == 1 {
                                        self.mViewModel.Application!.Items[self.mIndex].StartDate = value
                                        self.mViewModel.objectWillChange.send()
                                    }
                                })
                             Text(Utils.formatDate(format: "HH:mm ZZZZZ", date: self.mViewModel.Application!.Items[self.mIndex].StartDate))
                                .foregroundColor(Color.textDark)
                                .font(Font.headline.weight(.bold))
                         }
                     }
                     .padding(.all, 8)
                     .frame(minWidth: 0, maxWidth: .infinity)
                     .background(Color.inputBackgroud)
                     .cornerRadius(4)
                     .onTapGesture {
                        self.mDatePickerIndex = 1
                        self.showDatePicker.toggle()
                     }
                     HStack {
                         Image("calendar-alt")
                             .renderingMode(.template)
                             .resizable()
                             .frame(width: 30, height: 35)
                             .foregroundColor(Color.textDark)
                         VStack {
                             Text(Utils.formatDate(format: "dd MMMM yyyy", date: self.mViewModel.Application!.Items[self.mIndex].FinishDate))
                                .foregroundColor(Color.textDark)
                                .onChange(of:  $selectedDate.wrappedValue, perform: { value in
                                    if self.mDatePickerIndex == 2 {
                                        self.mViewModel.Application!.Items[self.mIndex].FinishDate = value
                                        self.mViewModel.objectWillChange.send()
                                    }
                                })
                             Text(Utils.formatDate(format: "HH:mm ZZZZZ", date: self.mViewModel.Application!.Items[self.mIndex].FinishDate))
                                .foregroundColor(Color.textDark)
                                .font(Font.headline.weight(.bold))
                         }
                     }
                     .padding(.all, 8)
                     .frame(minWidth: 0, maxWidth: .infinity)
                     .background(Color.inputBackgroud)
                     .cornerRadius(4)
                     .onTapGesture {
                        self.mDatePickerIndex = 2
                        self.showDatePicker.toggle()
                     }
                 }
                 VStack {
                    Text("Тип автотранспорта")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(Color.textLight)
                    NavigationLink(destination: PickerVehicleTypesView(vehicleType: $mSelectedVehicleType)) {
                        TextField("", text: Binding(
                                    get: { self.mViewModel.Application!.Items[self.mIndex].VehicleParams.VehicleType.getVehicleTypeName() },
                                    set: { _ in }))
                            .frame(minHeight: 30, maxHeight: 30)
                            .background(Color.inputBackgroud)
                            .foregroundColor(Color.textDark)
                            .cornerRadius(4)
                            .disabled(true)
                            .onChange(of:  $mSelectedVehicleType.wrappedValue, perform: { value in
                                self.mViewModel.Application!.Items[self.mIndex].VehicleParams.VehicleType = value
                                self.mViewModel.objectWillChange.send()
                            })
                        
                    }
                 }
                 /*ForEach(self.mApplicationItem.VehicleParams.VehicleOptions) { option in
                     if option.getOptionValue() != nil {
                         HStack {
                             Image("iconmonstr-gear")
                                 .renderingMode(.template)
                                 .foregroundColor(Color.textLight)
                             Text(option.VehicleOption.VehicleOptionType.Name)
                                 .frame(maxWidth: .infinity, alignment: .leading)
                                 .fixedSize(horizontal: false, vertical: true)
                                 .foregroundColor(Color.textLight)
                             Text(option.getOptionValue()!)
                                 .frame(maxWidth: .infinity, alignment: .leading)
                                 .fixedSize(horizontal: false, vertical: true)
                                 .foregroundColor(Color.textLight)
                                 .font(Font.headline.weight(.bold))
                         }
                     }
                 }*/
             }
             .padding(.all, 12)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color.primaryDark)
        .cornerRadius(5)
    }
}


