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
    @State var action: Int?
    
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
                    .background(Color.primary.edgesIgnoringSafeArea(.all))
                    .tabItem { TabBarItemView(label: "Заявка", image: "clipboard-list") }
            }
            else {
                ApplicationMainEditView(entityId: self.mEntityId, mode: self.mCurrentMode, action: $action)
                    .background(Color.primary.edgesIgnoringSafeArea(.all))
                    .tabItem { TabBarItemView(label: "Заявка", image: "clipboard-list") }
            }
            Text("Тут документы...")
                .background(Color.primary.edgesIgnoringSafeArea(.all))
                .tabItem { TabBarItemView(label: "Документы", image: "file-signature") }
            Text("Тут платежи...")
                .background(Color.primary.edgesIgnoringSafeArea(.all))
                .tabItem { TabBarItemView(label: "Платежи", image: "ruble-sign") }
            ApplicationHistoryView(entityId: self.mEntityId)
                .background(Color.primary.edgesIgnoringSafeArea(.all))
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
                        .onTapGesture {
                            self.action = 1
                        }
                    Image("paper-plane")
                        .renderingMode(.template)
                        .foregroundColor(Color.textLight)
                }
            }
        )
    }
}
