//
//  VehiclesRowView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 11.02.2022.
//

import SwiftUI

struct VehiclesRowView: View {
    var mVehicle: Vehicle
    
    init (_ vehicle: Vehicle) {
        self.mVehicle = vehicle
    }
    
    var body: some View {
        VStack {
            VStack {
                CustomText(self.mVehicle.RegNumber!, image: "license-plate-number")
                CustomText(self.mVehicle.Company!.getCompanyName(), image: "address-book")
                CustomText(self.mVehicle.VehicleType!.getVehicleTypeName(), image: "truck-monster")
            }
            .padding(.all, 8)
        }
        .background(Color.primaryDark)
        .cornerRadius(5)
        .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
    }
}
