//
//  ApplicationView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 09.01.2022.
//

import SwiftUI

struct ApplicationView: View {
    //@Environment(\.presentationMode) var presentationMode
    var mCurrentMode: ModeView
    @Binding var mEntityId: Int
    @State var SelectedItem: Int = 0
    @State var mAction: Int?
    
    init(entityId: Binding<Int>, mode: ModeView) {
        self._mEntityId = entityId
        self.mCurrentMode = mode
    }
    
    var body: some View {
        //NavigationView {
            VStack(spacing: 0) {
                switch self.SelectedItem {
                    case 0: ApplicationMainView(entityId: self.$mEntityId, mode: self.mCurrentMode)
                    case 1: Text("Тут документы...").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    case 2: Text("Тут счета...").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    case 3: ApplicationHistoryView(entityId: self.$mEntityId)
                    default: VStack {}
                }                
                CustomTabView(items: [
                    CustomTabItem(index: 0, label: "menu_application", image: "clipboard-list"),
                    CustomTabItem(index: 1, label: "menu_documents", image: "file-signature"),
                    CustomTabItem(index: 2, label: "menu_payments", image: "ruble-sign"),
                    CustomTabItem(index: 3, label: "menu_history", image: "history")
                ], selected: $SelectedItem)
            }
            .accentColor(Color.secondary)
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(false)
            .navigationBarTitle(String(format: NSLocalizedString("title_application", comment: ""), String(self.mEntityId)), displayMode: .inline)
            .navigationBarItems(trailing: HStack {
                Image("iconmonstr-edit")
                    .renderingMode(.template)
                    .foregroundColor(Color.textLight)
                    .onTapGesture {
                        self.mAction = 1
                    }
            })
        
            NavigationLink(destination: ApplicationEditView(entityId: self.$mEntityId, mode: ModeView.Edit), tag: 1, selection: $mAction)  {
            }
            .onChange(of: self.mAction) {newValue in
                //self.mAction = 0
            }
        }
    //}
}

