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
    @Binding var mVehicleType: VehicleType
    @State var mSelectedVehicleType: VehicleType?
    
    init(vehicleType: Binding<VehicleType>) {
        self._mVehicleType = vehicleType
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
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        .padding(EdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 4))
                                        .background(Color.textLight)
                                        .foregroundColor(Color.textDark)) {
                                    ForEach(self.mViewModel.Data.Elements.filter { $0.VehicleGroup != nil && $0.VehicleGroup!.Id == vehicleGroup.Id }) { vehicleType in
                                        VStack {
                                            Text(vehicleType.Name)
                                                .foregroundColor(self.mSelectedVehicleType == vehicleType ? Color.textDark : Color.textLight)
                                                .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
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
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(false)
        .navigationBarTitle("Выберите тип автотранспорта", displayMode: .inline)
        .onAppear {
            self.mViewModel.clearData()
            self.mViewModel.loadData()
        }
    }
}

