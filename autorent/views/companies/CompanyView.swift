//
//  CompanyView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 11.02.2022.
//

import SwiftUI

struct CompanyView: View {
    var mCurrentMode: ModeView
    var mEntityId: Int
    var mNames: [String]
    @State var SelectedTab: Int = 0
    @State var mEditMode: Bool?
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
                    CompanyMainView(entityId: self.mEntityId, mode: self.mCurrentMode, selectedStatus: self.SelectedStatus, action: $Action, result: $ActionResult)
                case 1:
                    CompanyDocumentsView(entityId: self.mEntityId, refresh: $Refresh)
                case 2:
                    CompanyHistoryView(entityId: self.mEntityId)
                default:
                    VStack {}
            }
            CustomTabView(items: [
                CustomTabItem(index: 0, label: "menu_company", image: "address-book"),
                CustomTabItem(index: 1, label: "menu_documents", image: "file-signature"),
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
                CustomTitle(title: String(format: NSLocalizedString("title_company", comment: ""), self.mNames[0]), subtitle: self.SelectedStatus.Status?.Name)
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
                                self.mEditMode = true
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
        .onChange(of: self.ActionResult) { newValue in
            if newValue != nil {
                if (newValue != OperationResult.Error) {
                    self.Refresh = true
                }
            }
        }
        .onChange(of: self.Refresh) { newValue in
            if newValue != nil {
                
            }
        }
        
        NavigationLink(destination: CompanyEditView(entityId: self.mEntityId, names: self.mNames, mode: ModeView.Edit, result: $ActionResult), tag: true, selection: $mEditMode)  { }
    }
}
