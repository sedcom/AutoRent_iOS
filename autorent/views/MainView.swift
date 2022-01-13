//
//  MainView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 09.01.2022.
//

import SwiftUI

struct MainView: View {
    @State var SelectedItem: Int = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if (self.SelectedItem == 0) {
                    MapView()
                }
                if (self.SelectedItem == 1) {
                    ApplicationsView()
                }
                if (self.SelectedItem == 2) {
                    Text("Тут заказы...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                if (self.SelectedItem == 3) {
                    Text("Тут счета...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                if (self.SelectedItem == 4) {
                    Text("Тут профиль...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                CustomTabView(items: [
                    CustomTabItem(index: 0, label: "menu_map", image: "map-marked-alt"),
                    CustomTabItem(index: 1, label: "Заявки", image: "clipboard-list"),
                    CustomTabItem(index: 2, label: "Заказы", image: "copy"),
                    CustomTabItem(index: 3, label: "Платежи", image: "ruble-sign"),
                    CustomTabItem(index: 4, label: "Профиль", image: "user"),
                ], selected: $SelectedItem)
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(false)
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
        switch self.SelectedItem {
            case 0: return "Карта"
            case 1: return "Заявки"
            case 2: return "Заказы"
            case 3: return "Платежи"
            case 4: return "Профиль"
            default: return ""
        }
    }
}
