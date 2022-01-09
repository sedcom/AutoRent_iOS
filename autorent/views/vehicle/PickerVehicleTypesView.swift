//
//  PickerVehicleTypesView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 06.01.2022.
//

import SwiftUI

struct PickerVehicleTypesView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var mViewModel: VehicleTypesViewModel
    @Binding var vehicleType: VehicleType
    @State var mSelectedVehicleType: VehicleType?
    
    init(vehicleType: Binding<VehicleType>) {
        self._vehicleType = vehicleType
        self.mViewModel = VehicleTypesViewModel(orderBy: "Name asc", include: "options")
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
                                                .foregroundColor(self.mSelectedVehicleType == vehicleType ? Color.textDark : Color.textLight)
                                                .onTapGesture {
                                                    self.mSelectedVehicleType = vehicleType
                                                }
                                        }
                                        .listRowBackground(self.mSelectedVehicleType == vehicleType ? Color.secondary : Color.primaryDark)
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
        .navigationBarTitle("Выберите тип автотранспорта", displayMode: .inline)
        .navigationBarItems(trailing:
            HStack {
                Image("check-circle")
                    .renderingMode(.template)
                    .foregroundColor(Color.textLight)
                    .onTapGesture {
                        if self.mSelectedVehicleType != nil {                            
                            self.presentationMode.wrappedValue.dismiss()
                            self.vehicleType = self.mSelectedVehicleType!
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

