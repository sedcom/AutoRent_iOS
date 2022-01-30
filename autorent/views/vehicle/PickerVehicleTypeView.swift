//
//  PickerVehicleTypeView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 06.01.2022.
//

import SwiftUI

struct PickerVehicleTypeView: View, Equatable {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var mViewModel: VehicleTypesViewModel
    @ObservedObject var SelectedVehicleType: VehicleTypeObservable
    @State var mSelectedItem: VehicleType?

    init(selectedVehicleType: VehicleTypeObservable) {
        self.SelectedVehicleType = selectedVehicleType
        self.mViewModel = VehicleTypesViewModel(orderBy: "Name asc", include: "options")
    }
    
    static func == (lhs: PickerVehicleTypeView, rhs: PickerVehicleTypeView) -> Bool {
        return true
    }
    
    var body: some View {
        VStack {
            if self.mViewModel.IsLoading == true {
                LoadingView()
            }
            else if self.mViewModel.IsError {
                ErrorView()
            }
            else {
                if self.mViewModel.Data.Elements.count == 0 {
                    EmptyView()
                }
                else {
                    VStack {
                        List {
                            ForEach(self.mViewModel.Data.Elements.filter { $0.VehicleGroup == nil }) { vehicleGroup in
                                Section(header:
                                    Text(vehicleGroup.Name)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                                        .background(Color.primary)
                                        .foregroundColor(Color.textLight)
                                        .font(Font.headline.weight(.bold))
                                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                                        .textCase(nil)) {
                                    ForEach(self.mViewModel.Data.Elements.filter { $0.VehicleGroup != nil && $0.VehicleGroup!.Id == vehicleGroup.Id }) { vehicleType in
                                        VStack {
                                            Text(vehicleType.Name)
                                                .foregroundColor(self.mSelectedItem == vehicleType ? Color.textDark : Color.textLight)
                                                .onTapGesture {
                                                    self.mSelectedItem = vehicleType
                                                }
                                        }
                                        .listRowBackground(self.mSelectedItem == vehicleType ? Color.secondary : Color.primaryDark)
                                    }
                                }
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                    .background(Color.primaryDark)
                }
            }
        }
        .background(Color.primary.edgesIgnoringSafeArea(.all))
        .navigationBarHidden(false)
        .navigationBarTitle(NSLocalizedString("title_picker_vehicletypes", comment: ""), displayMode: .inline)
        .navigationBarItems(trailing:
            HStack {
                Image("check-circle")
                    .renderingMode(.template)
                    .foregroundColor(Color.textLight)
                    .onTapGesture {
                        if self.mSelectedItem != nil {
                            self.SelectedVehicleType.VehicleType = self.mSelectedItem!
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
            }
        )
        .onAppear {
            self.mViewModel.clearData()
            self.mViewModel.loadData()
        }
    }
}
