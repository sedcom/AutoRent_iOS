//
//  PickerVehicleTypesView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 06.01.2022.
//

import SwiftUI

struct PickerVehicleTypesView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var mVehicleType: VehicleType
    
    init(vehicleType: Binding<VehicleType>) {
        _mVehicleType = vehicleType
    }
    
    var body: some View {
        Text("Click me")
            .onTapGesture {
                //_mVehicleType = Binding(get: { VehicleType(id: 901, name: "New vehicle") }, set: { _ in })
                mVehicleType = VehicleType(id: 901, name: "New vehicle")
                self.presentationMode.wrappedValue.dismiss()
            }
    }
}

