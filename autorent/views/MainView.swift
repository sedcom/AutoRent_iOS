//
//  MainView.swift
//  autorent
//
//  Created by Semyon Kravchenko on 29.11.2021.
//

import SwiftUI

struct MainView: View {
    
    init() {
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
        NavigationView {
            TabView {
                MapView()
                    .tabItem { TabBarItemView(label: NSLocalizedString("menu_map", comment: ""), image: "map-marked-alt") }
                    .navigationBarHidden(true)
                ApplicationsView()
                    .tabItem { TabBarItemView(label: "Заявки", image: "clipboard-list") }
                Text("Тут заказы...")
                    .tabItem { TabBarItemView(label: "Заказы", image: "copy") }
                Text("Тут счета...")
                    .tabItem { TabBarItemView(label: "Платежи", image: "ruble-sign") }
                Text("Тут профиль...")
                    .tabItem { TabBarItemView(label: "Профиль", image: "user") }
            }
            .accentColor(Color.secondary).navigationBarHidden(true)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
