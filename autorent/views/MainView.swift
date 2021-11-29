//
//  MainView.swift
//  autorent
//
//  Created by Semyon Kravchenko on 29.11.2021.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            Text("Тут карта...")
            .tabItem {
                Text("Карта")
            }
            Text("Тут заявки...")
            .tabItem {
                Image("")
                Text("Заявки")
            }
            Text("Тут заказы...")
            .tabItem {
                Text("Заказы")
            }
            Text("Тут счета...")
            .tabItem {
                Text("Платежи")
            }
            Text("Тут профиль...")
            .tabItem {
                Text("Профиль")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
