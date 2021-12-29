//
//  autorentApp.swift
//  autorent
//
//  Created by Semyon Kravchenko on 27.11.2021.
//

import SwiftUI

@main
struct autorentApp: App {
    init() {
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.lightText,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)
        ]
        let tabAppearance = UITabBarAppearance()
        tabAppearance.configureWithOpaqueBackground()
        tabAppearance.backgroundColor = UIColor(Color.primaryDark)
        tabAppearance.stackedLayoutAppearance = itemAppearance
        UITabBar.appearance().standardAppearance = tabAppearance
        
        UITableView.appearance().separatorColor = .clear
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().tableFooterView = UIView()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
