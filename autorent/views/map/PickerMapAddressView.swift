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
        MapView(selectedMapAddress: self.SelectedMapAddress)
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
