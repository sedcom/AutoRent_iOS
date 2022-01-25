//
//  ApplicationView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 09.01.2022.
//

import SwiftUI

struct ApplicationView: View {
    var mCurrentMode: ModeView
    var mEntityId: Int
    @State var SelectedTab: Int = 0
    @StateObject var SelectedStatus = StatusObservable()
    @State var EditMode: Bool?
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
                    ApplicationMainView(entityId: self.mEntityId, mode: self.mCurrentMode, selectedStatus: self.SelectedStatus, action: $Action, result: $ActionResult)
                case 1:
                    ApplicationDocumentsView(entityId: self.mEntityId)
                case 2:
                    ApplicationInvoicesView(entityId: self.mEntityId)
                case 3:
                    ApplicationHistoryView(entityId: self.mEntityId)
                default:
                    VStack {}
            }
            CustomTabView(items: [
                CustomTabItem(index: 0, label: "menu_application", image: "clipboard-list"),
                CustomTabItem(index: 1, label: "menu_documents", image: "file-signature"),
                CustomTabItem(index: 2, label: "menu_payments", image: "ruble-sign"),
                CustomTabItem(index: 3, label: "menu_history", image: "history")
            ], selected: $SelectedTab)
        }
        .edgesIgnoringSafeArea(.horizontal)
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(false)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                CustomTitle(title: String(format: NSLocalizedString("title_application", comment: ""), String(self.mEntityId)), subtitle: self.SelectedStatus.Status?.Name)
            }
        }
        .navigationBarItems(trailing:
            HStack(spacing: 10) {
                if self.SelectedTab == 0 {
                    if self.SelectedStatus.Status?.Id == 1 {
                        Image("iconmonstr-edit")
                            .renderingMode(.template)
                            .foregroundColor(Color.textLight)
                            .onTapGesture {
                                self.EditMode = true
                            }
                        Image("paper-plane")
                            .renderingMode(.template)
                            .foregroundColor(Color.textLight)
                            .onTapGesture {
                                self.Action = 2
                            }
                    }
                }
        })
    
        NavigationLink(destination: ApplicationEditView(entityId: self.mEntityId, mode: ModeView.Edit, result: $ActionResult), tag: true, selection: $EditMode)  { }
    }
}

