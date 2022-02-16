//
//  CompanyEditView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 16.02.2022.
//

import SwiftUI

struct CompanyEditView: View {
    var mCurrentMode: ModeView
    var mEntityId: Int
    var mNames: [String]
    @State var SelectedItem: Int = 0
    @State var Action: Int?
    @Binding var ActionResult: OperationResult?
    
    init(entityId: Int, names: [String] = [], mode: ModeView, result: Binding<OperationResult?>) {
        self.mEntityId = entityId
        self.mNames = names
        self.mCurrentMode = mode
        self._ActionResult = result
    }
    
    var body: some View {
        VStack(spacing: 0) {
            switch self.SelectedItem {
                case 0: CompanyMainEditView(entityId: self.mEntityId, mode: self.mCurrentMode, action: $Action, result: $ActionResult).equatable()
                    default: VStack {}
            }
            CustomTabView(items: [
                CustomTabItem(index: 0, label: "menu_company", image: "address-book"),
                CustomTabItem(index: 1, label: "menu_documents", image: "file-signature", disabled: true),
                CustomTabItem(index: 2, label: "menu_history", image: "history", disabled: true)
            ], selected: $SelectedItem)
        }
        .edgesIgnoringSafeArea(.horizontal)
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(false)
        .navigationBarTitle(self.mCurrentMode == ModeView.Create ?  NSLocalizedString("title_company_new", comment: "") : String(format: NSLocalizedString("title_company", comment: ""), self.mNames[0]), displayMode: .inline)
        .navigationBarItems(trailing:
            HStack(spacing: 10) {
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
