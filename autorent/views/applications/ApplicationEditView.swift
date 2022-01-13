//
//  ApplicationEditView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 09.01.2022.
//

import SwiftUI

struct ApplicationEditView: View {
    @Environment(\.presentationMode) var presentationMode
    var mCurrentMode: ModeView
    var mEntityId: Int
    @State var SelectedItem: Int = 0
    @State var action: Int?
    @State var mAction: Int?
    @State var selectedItems: [UUID] = []
    
    
    init(entityId: Int, mode: ModeView) {
        self.mEntityId = entityId
        self.mCurrentMode = mode
    }
    
    var body: some View {
        //NavigationView {
            VStack(spacing: 0) {
                switch self.SelectedItem {
                    case 0: ApplicationMainEditView(entityId: self.mEntityId, mode: self.mCurrentMode, action: $action, selectedItems: $selectedItems).equatable()
                    default: VStack {}
                }                
                CustomTabView(items: [
                    CustomTabItem(index: 0, label: "menu_application", image: "clipboard-list"),
                    CustomTabItem(index: 1, label: "menu_documents", image: "file-signature", disabled: true),
                    CustomTabItem(index: 2, label: "menu_payments", image: "ruble-sign", disabled: true),
                    CustomTabItem(index: 3, label: "menu_history", image: "history", disabled: true)
                ], selected: $SelectedItem)
            }
            .edgesIgnoringSafeArea(.horizontal)
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(false)
            .navigationBarTitle(self.mCurrentMode == ModeView.Create ?  NSLocalizedString("title_application_new", comment: "") : String(format: NSLocalizedString("title_application", comment: ""), String(self.mEntityId)), displayMode: .inline)
            .navigationBarItems(trailing: HStack {
                Image("check-circle")
                    .renderingMode(.template)
                    .foregroundColor(Color.textLight)
                    .opacity(self.selectedItems.count > 0 ? 1 : 0)
                    .onTapGesture {
                        self.action = 3
                    }
                Image("save")
                    .renderingMode(.template)
                    .foregroundColor(Color.textLight)
                    .onTapGesture {
                        self.action = 1
                    }
                Image("paper-plane")
                    .renderingMode(.template)
                    .foregroundColor(Color.textLight)
                    .onTapGesture {
                        self.mAction = 2
                        presentationMode.wrappedValue.dismiss()
                    }
            })
            
        NavigationLink(destination: ApplicationView(entityId: self.mEntityId, mode: ModeView.View), tag: 2, selection: $mAction)  {

            }
            .onChange(of: self.action) { newValue in
                if self.action == 5 {
                    //presentationMode.wrappedValue.dismiss()
                }
            }
        //}
    }
}
