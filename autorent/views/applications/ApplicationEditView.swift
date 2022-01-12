//
//  ApplicationEditView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 09.01.2022.
//

import SwiftUI

struct ApplicationEditView: View {
    //@Environment(\.presentationMode) var presentationMode
    var mCurrentMode: ModeView
    var mEntityId: Int
    @State var tabIdx: TabApplication = .tab1
    @State var action: Int?
    @State var selectedItems: [UUID] = []
    
    init(entityId: Int, mode: ModeView) {
        self.mEntityId = entityId
        self.mCurrentMode = mode
    }
    
    var body: some View {
        //NavigationView {
            VStack(spacing: 0) {
                if (self.tabIdx == .tab1) {
                    ApplicationMainEditView(entityId: self.mEntityId, mode: self.mCurrentMode, action: $action, selectedItems: $selectedItems).equatable()                    
                }
                if (self.tabIdx == .tab2) {
                    Text("Тут документы...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                if (self.tabIdx == .tab3) {
                    Text("Тут платежи...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                if (self.tabIdx == .tab4) {
                    ApplicationHistoryView(entityId: self.mEntityId)
                }
                ApplicationTabView(tabIdx: $tabIdx)
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
                        self.action = 2
                    }
            })
        }
    //}
}
