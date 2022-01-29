//
//  PickerMapAddressView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 16.01.2022.
//

import SwiftUI
import MapKit

struct PickerMapAddressView: View {
    @Environment(\.presentationMode) var presentationMode
    var mMap = MKMapView()
    @ObservedObject var SelectedMapAddress: AddressObservable
    
    init(selectedMapAddress: AddressObservable) {
        self.SelectedMapAddress = selectedMapAddress
    }
    
    var body: some View {
        MapView(map: self.mMap, selectedMapAddress: self.SelectedMapAddress)
        .background(Color.primary.edgesIgnoringSafeArea(.all))
        .navigationBarHidden(false)
        .navigationBarTitle(NSLocalizedString("title_picker_mapaddress", comment: ""), displayMode: .inline)
        .navigationBarItems(trailing:
            HStack {
                Image("check-circle")
                    .renderingMode(.template)
                    .foregroundColor(Color.textLight)
                    .onTapGesture {                    
                        self.presentationMode.wrappedValue.dismiss()
                    }
            }
        )
    }
}
