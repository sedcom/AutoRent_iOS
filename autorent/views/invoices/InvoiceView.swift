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
    var mNames: [String]
    @State var SelectedTab: Int = 0
    @State var SelectedStatus: Int?
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
            switch self.SelectedTab {
                case 0:
                    InvoiceMainView(entityId: self.mEntityId, mode: self.mCurrentMode, status: $SelectedStatus, result: $ActionResult)
                case 1:
                    InvoiceHistoryView(entityId: self.mEntityId)
                default:
                    VStack {}
            }
            CustomTabView(items: [
                CustomTabItem(index: 0, label: "menu_payment", image: "ruble-sign"),
                CustomTabItem(index: 1, label: "menu_history", image: "history")
            ], selected: $SelectedTab)
        }
        .edgesIgnoringSafeArea(.horizontal)
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(false)
        .navigationBarTitle(String(format: NSLocalizedString("title_invoice", comment: ""), self.mNames[0], self.mNames[1]), displayMode: .inline)
        .navigationBarItems(trailing:
            HStack(spacing: 10) {
                if self.SelectedTab == 0 {
                    if self.SelectedStatus == 2 {
                        Image("reply")
                            .renderingMode(.template)
                            .foregroundColor(Color.textLight)
                            .onTapGesture {
                                self.Action = 1
                            }
                        Image("visa")
                            .renderingMode(.template)
                            .foregroundColor(Color.textLight)
                            .onTapGesture {
                                self.Action = 2
                            }
                    }
                }
        })
    }
}

