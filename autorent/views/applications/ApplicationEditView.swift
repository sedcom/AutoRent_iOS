//
//  ApplicationEditView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 09.01.2022.
//

import SwiftUI

struct ApplicationEditView: View {
    var mCurrentMode: ModeView
    var mEntityId: Int
    var mAddress: Address?
    @State var SelectedItem: Int = 0
    @State var SelectedItems: [UUID] = []
    @State var Action: Int?
    @Binding var ActionResult: OperationResult?
    
    init(entityId: Int, mode: ModeView, address: Address? = nil, result: Binding<OperationResult?>) {
        self.mEntityId = entityId
        self.mCurrentMode = mode
        self.mAddress = address
        self._ActionResult = result
    }
    
    var body: some View {
        VStack(spacing: 0) {
            switch self.SelectedItem {
            case 0: ApplicationMainEditView(entityId: self.mEntityId, mode: self.mCurrentMode, address:  self.mAddress, action: $Action, selectedItems: $SelectedItems, result: $ActionResult).equatable()
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
        .navigationBarItems(trailing:
            HStack(spacing: 10) {
                Image("trash-alt")
                    .renderingMode(.template)
                    .foregroundColor(Color.textLight)
                    .opacity(self.SelectedItems.count > 0 ? 1 : 0)
                    .onTapGesture {
                        self.Action = 3
                    }
                Image("save")
                    .renderingMode(.template)
                    .foregroundColor(Color.textLight)
                    .onTapGesture {
                        self.Action = 1
                    }
                Image("paper-plane")
                    .renderingMode(.template)
                    .foregroundColor(Color.textLight)
                    .onTapGesture {
                        self.Action = 2
            }
        })
    }
}
