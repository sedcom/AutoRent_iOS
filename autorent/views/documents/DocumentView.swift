//
//  DocumentView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 21.01.2022.
//

import SwiftUI

struct DocumentView: View {
    var mCurrentMode: ModeView
    var mEntityId: Int
    var mNames: [String]
    @State var SelectedTab: Int = 0
    @StateObject var SelectedStatus = StatusObservable()
    @State var Action: Int?
    @State var ActionResult: OperationResult?
    @Binding var Refresh: Bool?
    
    init(entityId: Int, names: [String] = [], mode: ModeView, refresh: Binding<Bool?>) {
        self.mEntityId = entityId
        self.mNames = names
        self.mCurrentMode = mode
        self._Refresh = refresh
    }
    
    var body: some View {
        VStack(spacing: 0) {
            switch self.SelectedTab {
                case 0:
                    DocumentMainView(entityId: self.mEntityId, mode: self.mCurrentMode, selectedStatus: self.SelectedStatus, action: $Action, result: $ActionResult)
                case 1:
                    DocumentInvoicesView(entityId: self.mEntityId, refresh: $Refresh)
                case 2:
                    DocumentHistoryView(entityId: self.mEntityId)
                default:
                    VStack {}
            }
            CustomTabView(items: [
                CustomTabItem(index: 0, label: "menu_document", image: "file-signature"),
                CustomTabItem(index: 1, label: "menu_payments", image: "ruble-sign"),
                CustomTabItem(index: 2, label: "menu_history", image: "history")
            ], selected: $SelectedTab)
        }
        .edgesIgnoringSafeArea(.horizontal)
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(false)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {}
            }
            ToolbarItem(placement: .principal) {
                CustomTitle(title: String(format: NSLocalizedString("title_document", comment: ""), self.mNames[0], self.mNames[1]), subtitle: self.SelectedStatus.Status?.Name)
            }
        }
        .navigationBarItems(trailing:
            HStack(spacing: 10) {
                if self.SelectedTab == 0 {
                    if self.SelectedStatus.Status?.Id == 2 {
                        Image("feather")
                            .renderingMode(.template)
                            .foregroundColor(Color.textLight)
                            .onTapGesture {
                                self.Action = 1
                            }
                    }
                }
        })
        .onChange(of: self.ActionResult) { newValue in
            if newValue != nil {
                if newValue != OperationResult.Error {
                    self.Refresh = true
                }
            }
        }
    }
}
