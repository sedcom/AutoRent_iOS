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
        //
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.lightText,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)
        ]
        let tabAppearance = UITabBarAppearance()
        tabAppearance.configureWithOpaqueBackground()
        tabAppearance.backgroundColor = UIColor(Color.primaryDark)
        tabAppearance.stackedLayoutAppearance = itemAppearance
        UITabBar.appearance().standardAppearance = tabAppearance
    }
    
    var body: some View {
        TabView {
            ApplicationMainView(entityId: self.mEntityId)
                .tabItem { TabBarItemView(label: "Заявка", image: "clipboard-list") }
            Text("Тут документы...")
                .tabItem { TabBarItemView(label: "Документы", image: "file-signature") }
            Text("Тут платежи...")
                .tabItem { TabBarItemView(label: "Платежи", image: "ruble-sign") }
            Text("Тут история...")
                .tabItem { TabBarItemView(label: "История", image: "history") }        }
        .accentColor(Color.secondary).navigationBarHidden(true)
    }
}
