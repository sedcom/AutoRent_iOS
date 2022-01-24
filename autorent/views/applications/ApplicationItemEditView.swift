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
    @Binding var ShowDatePicker: Bool
    @Binding var SelectedDate: Date
    @Binding var SelectedItems: [UUID]
    @State var mDatePickerIndex: Int = 0
    @State var mIsSelected: Bool = false
    @StateObject var SelectedVehicleType = VehicleTypeObservable()
    
    init(viewModel: ApplicationViewModel, mode: ModeView, index: Int, showDatePicker: Binding<Bool>, selectedDate: Binding<Date>, selectedItems: Binding<[UUID]>) {
        self.mViewModel = viewModel
        self.mCurrentMode = mode
        self.mIndex = index
        self._ShowDatePicker = showDatePicker
        self._SelectedDate = selectedDate
        self._SelectedItems = selectedItems
    }
    
    var body: some View {
        VStack {
            if self.mIndex < self.mViewModel.Application!.Items.count {
                VStack {
                    VStack {
                        CustomText(String(format: NSLocalizedString("string_applicationitem_title", comment: ""), String(self.mIndex + 1)), alignment: .trailing, maxLines: 1, bold: true, color: self.mIsSelected ? Color.textDark : Color.textLight)
                    }
                    HStack {
                        HStack {
                             Image("calendar-alt")
                                 .resizable()
                                 .frame(width: 30, height: 35)
                                 .foregroundColor(Color.textDark)
                             VStack {
                                 CustomText(Utils.formatDate(format: "dd MMMM yyyy", date: self.mViewModel.Application!.Items[self.mIndex].StartDate), alignment: .center, maxLines: 1, color: Color.textDark)
                                    .onChange(of:  $SelectedDate.wrappedValue, perform: { value in
                                        if self.mDatePickerIndex == 1 {
                                            self.mViewModel.Application!.Items[self.mIndex].StartDate = value
                                            self.mViewModel.updateApplicationItem(item: self.mViewModel.Application!.Items[self.mIndex])
                                        }
                                    })
                                CustomText(Utils.formatDate(format: "HH:mm ZZZZZ", date: self.mViewModel.Application!.Items[self.mIndex].StartDate), alignment: .center, maxLines: 1, bold: true, color: Color.textDark)
                             }
                         }
                        .padding(EdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8))
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color.inputBackgroud)
                        .cornerRadius(4)
                        .onTapGesture {
                            self.mDatePickerIndex = 1
                            self.ShowDatePicker.toggle()
                         }
                        HStack {
                            Image("calendar-alt")
                                .resizable()
                                .frame(width: 30, height: 35)
                                .foregroundColor(Color.textDark)
                            VStack {
                                CustomText(Utils.formatDate(format: "dd MMMM yyyy", date: self.mViewModel.Application!.Items[self.mIndex].FinishDate), alignment: .center, maxLines: 1, color: Color.textDark)
                                .onChange(of:  $SelectedDate.wrappedValue, perform: { value in
                                    if self.mDatePickerIndex == 2 {
                                        self.mViewModel.Application!.Items[self.mIndex].FinishDate = value
                                        self.mViewModel.updateApplicationItem(item: self.mViewModel.Application!.Items[self.mIndex])
                                    }
                                })
                                CustomText(Utils.formatDate(format: "HH:mm ZZZZZ", date: self.mViewModel.Application!.Items[self.mIndex].FinishDate), alignment: .center, maxLines: 1, bold: true, color: Color.textDark)
                             }
                         }
                        .padding(EdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8))
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color.inputBackgroud)
                        .cornerRadius(4)
                        .onTapGesture {
                            self.mDatePickerIndex = 2
                            self.ShowDatePicker.toggle()
                         }
                    }
                    VStack {
                        CustomText("string_vehicle_type", maxLines: 1, color: self.mIsSelected ? Color.textDark : Color.textLight)
                        NavigationLink(destination: PickerVehicleTypeView(selectedVehicleType: self.SelectedVehicleType)) {
                            CustomTextField(Binding(get: { self.mIndex < self.mViewModel.Application!.Items.count ? self.mViewModel.Application!.Items[self.mIndex].VehicleParams.VehicleType.getVehicleTypeName(): "" }, set: { _ in }), disabled: true)
                            .onChange(of:  self.SelectedVehicleType.VehicleType, perform: { value in
                                self.mViewModel.Application!.Items[self.mIndex].VehicleParams.VehicleType = value!
                                self.mViewModel.updateApplicationItem(item: self.mViewModel.Application!.Items[self.mIndex])
                             })
                        }
                    }
                    VStack {
                        /*ForEach(self.mViewModel.Application!.Items[self.mIndex].VehicleParams.VehicleOptions) { option in
                             if option.getOptionValue() != nil {
                                VStack {
                                    CustomText(option.VehicleOption.VehicleOptionType.Name, selected: self.mIsSelected)
                                    CustomTextField(Binding(get: { option.getOptionValue()! }, set: {_ in }))
                                 }
                             }
                         }*/
                    }
                 }
                .padding(.all, 12)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(self.mIsSelected ? Color.secondary : Color.primaryDark)
        .cornerRadius(5)        
        .onTapGesture {
            self.mIsSelected.toggle()
            if self.mIsSelected {
                let uuid = self.mViewModel.Application!.Items[self.mIndex].id
                self.SelectedItems.append(uuid)
            }
            else {
                let uuid = self.mViewModel.Application!.Items[self.mIndex].id
                let index = self.SelectedItems.firstIndex(of: uuid)
                self.SelectedItems.remove(at: index!)
            }
        }
    }
}


