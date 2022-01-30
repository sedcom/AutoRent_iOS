//
//  MapWrapperView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 24.01.2022.
//

import SwiftUI
import MapKit

struct MapWrapperView: View {
    @StateObject var SelectedMapAddress = AddressObservable()
    var mMap = MKMapView()
    @State var ActionMode: Int?
    @State var SelectedPoint: Bool = false
    @State var ShowBottomSheet: Bool = false
    @State var Action: Int?
    @State var ActionResult: OperationResult?
    
    var body: some View {
        ZStack {
            MapView(map: self.mMap, currentMapAddress: AddressObservable(), mode: $ActionMode, selectedMapAddress: self.SelectedMapAddress)
            ZStack {
                VStack {
                    Image("iconmonstr-flag")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.textDark)
                }
                .padding(.all, 8)
                .background(self.SelectedPoint ? Color.secondary : Color.white)
                .cornerRadius(8)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(self.SelectedPoint ? Color.textDark : Color.textLight, lineWidth: 1))
                .onTapGesture {
                    self.SelectedPoint.toggle()
                    self.ActionMode = self.SelectedPoint ? 1 : 0
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .offset(x: 10, y: 10)
            BottomSheet(show: $ShowBottomSheet, maxHeight: 120) {
                VStack {
                    CustomText("menu_application_create", bold: true, image: "paper-plane", color: Color.textDark)
                        .padding(.bottom, 8)
                        .onTapGesture {
                            self.ShowBottomSheet = false
                            self.Action = 1
                        }
                    CustomText("menu_point_remove", bold: true, image: "iconmonstr-flag-white", color: Color.textDark)
                        .onTapGesture {
                            self.ShowBottomSheet = false
                            self.mMap.removeAnnotations(self.mMap.annotations)
                        }
                }
                .padding(.all, 12)
            }
        }
        .onChange(of: self.SelectedMapAddress) { newValue in
            if newValue.Address != nil {
                self.ShowBottomSheet = true
            }
        }
        
        NavigationLink(destination: ApplicationEditView(entityId: 0, mode: ModeView.Create, address: self.SelectedMapAddress.Address, result: $ActionResult), tag: 1, selection: $Action)  { }
    }
}

