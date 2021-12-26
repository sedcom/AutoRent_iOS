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
                .tabItem { TabBarItemView(label: "Заявка", image: "map-marked-alt") }
            Text("Тут документы...")
                .tabItem { TabBarItemView(label: "Документы", image: "map-marked-alt") }
            Text("Тут платежи...")
                .tabItem { TabBarItemView(label: "Платежи", image: "map-marked-alt") }
            Text("Тут история...")
                .tabItem { TabBarItemView(label: "История", image: "map-marked-alt") }        }
        .accentColor(Color.secondary).navigationBarHidden(true)
    }
}
