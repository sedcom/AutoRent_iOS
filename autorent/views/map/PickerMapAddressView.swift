//
//  PickerMapAddressView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 16.01.2022.
//

import SwiftUI

struct PickerMapAddressView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var SelectedMapAddress: AddressObservable
    
    init(selectedMapAddress: AddressObservable) {
        self.SelectedMapAddress = selectedMapAddress
    }
    
    var body: some View {
        MapView()
        .background(Color.primary.edgesIgnoringSafeArea(.all))
        .navigationBarHidden(false)
        .navigationBarTitle(NSLocalizedString("title_picker_mapaddress", comment: ""), displayMode: .inline)
        .navigationBarItems(trailing:
            HStack {
                Image("check-circle")
                    .renderingMode(.template)
                    .foregroundColor(Color.textLight)
                    .onTapGesture {
                        let address = autorent.Address()
                        address.AddressType = AddressType(id: 3, name: "")
                        address.PostIndex = "123456"
                        address.Region = AddressRegion(name: "Moscow")
                        address.District = AddressDistrict()
                        address.City = AddressCity(name: "Moscow")
                        address.Street = AddressStreet(name: "Lenina")
                        address.House = "1"
                        self.SelectedMapAddress.Address = address
                        self.presentationMode.wrappedValue.dismiss()
                    }
            }
        )
    }
}
