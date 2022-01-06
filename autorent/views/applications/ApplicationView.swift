//
//  ApplicationView.swift
//  autorent
//
//  Created by Semyon Kravchenko on 29.11.2021.
//

import SwiftUI

struct ApplicationView: View {
    var mCurrentMode: ModeView
    var mEntityId: Int
    
    init(entityId: Int, mode: ModeView) {
        self.mEntityId = entityId
        self.mCurrentMode = mode
    }
    
    var body: some View {
        //NavigationView {
        TabView {
            if self.mCurrentMode == ModeView.View {
                //NavigationView {
                ApplicationMainView(entityId: self.mEntityId)
                //}
                    .tabItem { TabBarItemView(label: "Заявка", image: "clipboard-list") }
            }
            else {
                ApplicationMainEditView(entityId: self.mEntityId, mode: self.mCurrentMode)
                    .tabItem { TabBarItemView(label: "Заявка", image: "clipboard-list") }
            }
            Text("Тут документы...")
                .tabItem { TabBarItemView(label: "Документы", image: "file-signature") }
            Text("Тут платежи...")
                .tabItem { TabBarItemView(label: "Платежи", image: "ruble-sign") }
            ApplicationHistoryView(entityId: self.mEntityId)
                .tabItem { TabBarItemView(label: "История", image: "history") }
        }
        .accentColor(Color.secondary)
        //}
        .navigationBarHidden(false)
        .navigationBarTitle("Заявка №\(self.mEntityId)", displayMode: .inline)
        .navigationBarItems(trailing:
            HStack {
                if self.mCurrentMode == ModeView.View {
                    NavigationLink(destination: ApplicationView(entityId: self.mEntityId, mode: ModeView.Edit)) {
                        Image("iconmonstr-edit")
                            .renderingMode(.template)
                            .foregroundColor(Color.textLight)
                    }
                }
                if self.mCurrentMode == ModeView.Create || self.mCurrentMode == ModeView.Edit  {
                    Image("save")
                        .renderingMode(.template)
                        .foregroundColor(Color.textLight)
                    Image("paper-plane")
                        .renderingMode(.template)
                        .foregroundColor(Color.textLight)
                }
            }
        )
    }
}
