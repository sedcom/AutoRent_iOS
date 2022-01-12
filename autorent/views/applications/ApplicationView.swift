//
//  ApplicationView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 09.01.2022.
//

import SwiftUI

struct ApplicationView: View {
    //@Environment(\.presentationMode) var presentationMode
    var mCurrentMode: ModeView
    var mEntityId: Int
    @State var tabIdx: TabApplication = .tab1
    
    init(entityId: Int, mode: ModeView) {
        self.mEntityId = entityId
        self.mCurrentMode = mode
    }
    
    var body: some View {
        //NavigationView {
            VStack(spacing: 0) {
                if (self.tabIdx == .tab1) {
                    ApplicationMainView(entityId: self.mEntityId, mode: self.mCurrentMode)
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
            .navigationBarTitle("Application #.\(self.mEntityId)", displayMode: .inline)
            .navigationBarItems(trailing: HStack {
                NavigationLink(destination: ApplicationEditView(entityId: self.mEntityId, mode: ModeView.Edit)) {
                    Image("iconmonstr-edit")
                        .renderingMode(.template)
                        .foregroundColor(Color.textLight)                        
                }
            })
        }
    //}
}

