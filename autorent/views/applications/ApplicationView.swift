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
                if (self.SelectedItem == 0) {
                    ApplicationMainView(entityId: self.$mEntityId, mode: self.mCurrentMode)
                }
                if (self.SelectedItem == 1) {
                    Text("Тут документы...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                if (self.SelectedItem == 2) {
                    Text("Тут платежи...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                if (self.SelectedItem == 3) {
                    ApplicationHistoryView(entityId: self.$mEntityId)
                }
                CustomTabView(items: [
                    CustomTabItem(index: 0, label: "Заявка", image: "clipboard-list"),
                    CustomTabItem(index: 1, label: "Документы", image: "file-signature"),
                    CustomTabItem(index: 2, label: "Платежи", image: "ruble-sign"),
                    CustomTabItem(index: 3, label: "История", image: "history"),
                ], selected: $SelectedItem)
            }
            .accentColor(Color.secondary)
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(false)
            .navigationBarTitle("Application #.\(self.mEntityId)", displayMode: .inline)
            .navigationBarItems(trailing: HStack {
                //NavigationLink(destination: ApplicationEditView(entityId: self.mEntityId, mode: ModeView.Edit)) {
                    Image("iconmonstr-edit")
                        .renderingMode(.template)
                        .foregroundColor(Color.textLight)
                        .onTapGesture {
                            self.mAction = 1
                        }
                //}
            })
        
            NavigationLink(destination: ApplicationEditView(entityId: self.$mEntityId, mode: ModeView.Edit), tag: 1, selection: $mAction)  {
            }
            .onChange(of: self.mAction) {newValue in
                //self.mAction = 0
            }
        }
    //}
}

