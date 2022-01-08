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
                    .edgesIgnoringSafeArea(.horizontal)
                    .tabItem { TabBarItemView(label: NSLocalizedString("menu_map", comment: ""), image: "map-marked-alt") }
                    .tag(0)
                ApplicationsView()
                    .background(Color.primary.edgesIgnoringSafeArea(.all))
                    .tabItem { TabBarItemView(label: "Заявки", image: "clipboard-list") }
                    .tag(1)
                Text("Тут заказы...")
                    .background(Color.primary.edgesIgnoringSafeArea(.all))
                    .tabItem { TabBarItemView(label: "Заказы", image: "copy") }
                    .tag(2)
                Text("Тут счета...")
                    .background(Color.primary.edgesIgnoringSafeArea(.all))
                    .tabItem { TabBarItemView(label: "Платежи", image: "ruble-sign") }
                    .tag(3)
                Text("Тут профиль...")
                    .background(Color.primary.edgesIgnoringSafeArea(.all))
                    .tabItem { TabBarItemView(label: "Профиль", image: "user") }
                    .tag(4)
            
            }
            .accentColor(Color.secondary)
            .navigationBarTitle(getTitle(), displayMode: .inline)
            .navigationBarItems(trailing:
                HStack {
                    Image("comment-dots")
                        .renderingMode(.template)
                        .foregroundColor(Color.textLight)
                    Image("bell")
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
