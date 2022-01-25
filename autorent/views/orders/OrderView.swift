//
//  OrderView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 21.01.2022.
//

import SwiftUI

struct OrderView: View {
    var mCurrentMode: ModeView
    var mEntityId: Int
    @State var SelectedTab: Int = 0
    @StateObject var SelectedStatus = StatusObservable()
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
                    OrderMainView(entityId: self.mEntityId, mode: self.mCurrentMode, selectedStatus: self.SelectedStatus, action: $Action, result: $ActionResult)
                case 1:
                    OrderDocumentsView(entityId: self.mEntityId)
                case 2:
                    OrderInvoicesView(entityId: self.mEntityId)
                case 3:
                    OrderHistoryView(entityId: self.mEntityId)
                default:
                    VStack {}
            }
            CustomTabView(items: [
                CustomTabItem(index: 0, label: "menu_order", image: "copy"),
                CustomTabItem(index: 1, label: "menu_documents", image: "file-signature"),
                CustomTabItem(index: 2, label: "menu_payments", image: "ruble-sign"),
                CustomTabItem(index: 3, label: "menu_history", image: "history")
            ], selected: $SelectedTab)
        }
        .edgesIgnoringSafeArea(.horizontal)
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(false)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {}
            }
            ToolbarItem(placement: .principal) {
                CustomTitle(title: String(format: NSLocalizedString("title_order", comment: ""), String(self.mEntityId)), subtitle: self.SelectedStatus.Status?.Name)
            }
        }
        .navigationBarItems(trailing:
            HStack(spacing: 10) {
                if self.SelectedTab == 0 {
                    if self.SelectedStatus.Status?.Id == 2 {
                        Image("iconmonstr-edit")
                            .renderingMode(.template)
                            .foregroundColor(Color.textLight)
                            .onTapGesture {
                                self.Action = 1
                        }
                        Image("hand-paper")
                            .renderingMode(.template)
                            .foregroundColor(Color.textLight)
                            .onTapGesture {
                                self.Action = 2
                        }
                    }
                    if self.SelectedStatus.Status?.Id == 5 {
                        Image("flag-checkered")
                            .renderingMode(.template)
                            .foregroundColor(Color.textLight)
                            .onTapGesture {
                                self.Action = 3
                            }
                    }
                }
        })
        
        /*NavigationLink(destination: OrderEditView(entityId: self.mEntityId, mode: ModeView.Edit, result: $ActionResult), tag: 1, selection: $Action)  { }*/
    }
}
