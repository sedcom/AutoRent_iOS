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
    @State var mPaymentMode: Bool?
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
                    InvoiceMainView(entityId: self.mEntityId, mode: self.mCurrentMode, selectedStatus: self.SelectedStatus, action: $Action, result: $ActionResult)
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
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {}
            }
            ToolbarItem(placement: .principal) {
                CustomTitle(title: String(format: NSLocalizedString("title_invoice", comment: ""), self.mNames[0], self.mNames[1]), subtitle: self.SelectedStatus.Status?.Name)
            }
        }
        .navigationBarItems(trailing:
            HStack(spacing: 10) {
                if self.SelectedTab == 0 {
                    if self.SelectedStatus.Status?.Id == 2 {
                        /*Image("reply")
                            .renderingMode(.template)
                            .foregroundColor(Color.textLight)
                            .onTapGesture {
                                self.Action = 1
                            }*/
                        Image("visa")
                            .renderingMode(.template)
                            .foregroundColor(Color.textLight)
                            .onTapGesture {
                                self.mPaymentMode = true
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
        
        NavigationLink(destination: InvoicePaymentView(entityId: self.mEntityId, title: String(format: NSLocalizedString("title_invoice", comment: ""), self.mNames[0], self.mNames[1])), tag: true, selection: $mPaymentMode)  { }
    }
}

