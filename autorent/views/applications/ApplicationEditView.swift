//
//  ApplicationEditView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 09.01.2022.
//

import SwiftUI

struct ApplicationEditView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var mEntityId: Int
    @State var SelectedItem: Int = 0
    @State var action: Int?
    @State var mAction: Int?
    @State var selectedItems: [UUID] = []
    var mCurrentMode: ModeView = ModeView.View
    
    init(entityId: Binding<Int>, mode: ModeView) {
        self._mEntityId = entityId
        self.mCurrentMode = mode
    }
    
    var body: some View {
        //NavigationView {
            VStack(spacing: 0) {
                if (self.SelectedItem == 0) {
                    ApplicationMainEditView(entityId: self.$mEntityId, mode: self.mCurrentMode, action: $action, selectedItems: $selectedItems).equatable()
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
                    CustomTabItem(index: 1, label: "Документы", image: "file-signature", disabled: true),
                    CustomTabItem(index: 2, label: "Платежи", image: "ruble-sign", disabled: true),
                    CustomTabItem(index: 3, label: "История", image: "history", disabled: true),
                ], selected: $SelectedItem)
            }
            .accentColor(Color.secondary)
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(false)
            .navigationBarTitle("New/Edit", displayMode: .inline)
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
            
        NavigationLink(destination: ApplicationView(entityId: Binding(get: { 55475 }, set: {_ in }), mode: ModeView.View), tag: 2, selection: $mAction)  {

            }
            .onChange(of: self.action) { newValue in
                if self.action == 5 {
                    //presentationMode.wrappedValue.dismiss()
                }
            }
        //}
    }
}
