//
//  MainView.swift
//  autorent
//
//  Created by Semyon Kravchenko on 29.11.2021.
//

import SwiftUI

struct MainView: View {
    @State private var mSelected = 0
    
    var body: some View {
        NavigationView {
            TabView(selection: $mSelected) {
                MapView()
                    .tabItem { TabBarItemView(label: NSLocalizedString("menu_map", comment: ""), image: "map-marked-alt") }
                    .tag(0)
                ApplicationsView()
                    .tabItem { TabBarItemView(label: "Заявки", image: "clipboard-list") }
                    .tag(1)
                Text("Тут заказы...")
                    .tabItem { TabBarItemView(label: "Заказы", image: "copy") }
                    .tag(2)
                Text("Тут счета...")
                    .tabItem { TabBarItemView(label: "Платежи", image: "ruble-sign") }
                    .tag(3)
                Text("Тут профиль...")
                    .tabItem { TabBarItemView(label: "Профиль", image: "user") }
                    .tag(4)
            
            }
            .accentColor(Color.secondary)
            .navigationBarTitle(getTitle(), displayMode: .inline)
            .navigationBarItems(trailing:
                HStack {
                    Image("iconmonstr-gear")
                        .renderingMode(.template)
                        .foregroundColor(Color.textLight)
                    Image("iconmonstr-gear")
                        .renderingMode(.template)
                        .foregroundColor(Color.textLight)
                })
        }
    }
    
    func getTitle() -> String {
        switch self.mSelected {
            case 0: return "Карта"
            case 1: return "Заявки"
            case 2: return "Заказы"
            case 3: return "Платежи"
            case 4: return "Профиль"
            default: return ""
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
