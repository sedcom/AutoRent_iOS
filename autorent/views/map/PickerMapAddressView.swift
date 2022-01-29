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
    @State var ActionMode: Int? = 1
    @ObservedObject var SelectedMapAddress: AddressObservable
    
    init(selectedMapAddress: AddressObservable) {
        self.SelectedMapAddress = selectedMapAddress
    }
    
    var body: some View {
        ZStack {
            MapView(map: self.mMap, mode: $ActionMode, selectedMapAddress: self.SelectedMapAddress)
            ZStack {
                VStack {
                    Image("iconmonstr-flag")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.textDark)
                }
                .padding(.all, 8)
                .background(Color.secondary)
                .cornerRadius(8)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.textDark, lineWidth: 1))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .offset(x: 10, y: 10)
        }
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
