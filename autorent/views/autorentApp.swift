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
        /* let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(Color.textLight),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)
        ]
        let tabAppearance = UITabBarAppearance()
        tabAppearance.configureWithOpaqueBackground()
        tabAppearance.backgroundColor = UIColor(Color.primaryDark)
        tabAppearance.stackedLayoutAppearance = itemAppearance
        UITabBar.appearance().standardAppearance = tabAppearance */
        //
        let titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(Color.textLight),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        UINavigationBar.appearance().backgroundColor = UIColor(Color.primary)
        UINavigationBar.appearance().barTintColor = UIColor(Color.primary)
        UINavigationBar.appearance().titleTextAttributes = titleTextAttributes
        UINavigationBar.appearance().largeTitleTextAttributes = titleTextAttributes
        //
        UITableView.appearance().backgroundColor = UIColor.clear
        UITableViewCell.appearance().backgroundColor = UIColor.clear
        UITableViewHeaderFooterView.appearance().backgroundView = .init()
        //
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.secondary)
        UISegmentedControl.appearance().setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor(Color.textDark)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor(Color.textLight)], for: .normal)
        
        /*if #available(iOS 15, *) {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                UINavigationBar.appearance().standardAppearance = appearance
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
                UINavigationBar.appearance().compactAppearance = appearance
         }*/
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
