//
//  InvoiceView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 22.01.2022.
//

import SwiftUI

struct InvoiceView: View {
    var mCurrentMode: ModeView
    var mEntityId: Int
    @State var SelectedTab: Int = 0
    @State var SelectedStatus: Int?
    @State var Action: Int?
    @Binding var ActionResult: OperationResult?
    
    init(entityId: Int, mode: ModeView, result: Binding<OperationResult?>) {
        self.mEntityId = entityId
        self.mCurrentMode = mode
        self._ActionResult = result
    }
    
    var body: some View {
        VStack(spacing: 0) {
            switch self.SelectedTab {
                case 0:
                    Text("Тут счет...").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                case 1:
                    InvoiceHistoryView(entityId: self.mEntityId)
                default:
                    VStack {}
            }
            CustomTabView(items: [
                CustomTabItem(index: 0, label: "menu_payments", image: "ruble-sign"),
                CustomTabItem(index: 1, label: "menu_history", image: "history")
            ], selected: $SelectedTab)
        }
        .edgesIgnoringSafeArea(.horizontal)
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(false)
        .navigationBarTitle(String(format: NSLocalizedString("title_invoice", comment: ""), "", String(self.mEntityId)), displayMode: .inline)
        .navigationBarItems(trailing:
            HStack(spacing: 10) {
                if (self.SelectedTab == 0 && self.SelectedStatus == 2) {
                    Image("iconmonstr-edit")
                        .renderingMode(.template)
                        .foregroundColor(Color.textLight)
                        .onTapGesture {
                            self.Action = 1
                        }
                }
        })
    }
}

