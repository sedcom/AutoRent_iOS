//
//  ApplicationView.swift
//  autorent
//
//  Created by Semyon Kravchenko on 29.11.2021.
//

import SwiftUI

struct ApplicationView: View {
    var mEntityId: Int
    
    init(entityId: Int) {
        self.mEntityId = entityId
    }
    
    var body: some View {
        NavigationView {
            TabView {
                ApplicationMainView(entityId: self.mEntityId)
                    .tabItem { TabBarItemView(label: "Заявка", image: "clipboard-list") }
                Text("Тут документы...")
                    .tabItem { TabBarItemView(label: "Документы", image: "file-signature") }
                Text("Тут платежи...")
                    .tabItem { TabBarItemView(label: "Платежи", image: "ruble-sign") }
                ApplicationHistoryView(entityId: self.mEntityId)
                    .tabItem { TabBarItemView(label: "История", image: "history") }
            }
            .accentColor(Color.secondary)
        }
        .navigationBarHidden(false)
        .navigationBarTitle("Заявка №\(self.mEntityId)", displayMode: .inline)
        .navigationBarItems(trailing:
            HStack {
                Image("iconmonstr-gear")
                    .renderingMode(.template)
                    .foregroundColor(Color.textLight)
                Image("iconmonstr-gear")
                    .renderingMode(.template)
                    .foregroundColor(Color.textLight)
            }
        )
        
    }
}
