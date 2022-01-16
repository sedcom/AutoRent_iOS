//
//  MainView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 09.01.2022.
//

import SwiftUI

enum OperationResult {
   case Error, Create, Update, Send
}

struct MainView: View {
    @State var SelectedItem: Int = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                switch self.SelectedItem {
                    case 0: MapView()
                    case 1: ApplicationsView()
                    case 2: Text("Тут заказы...").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    case 3: Text("Тут счета...").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    case 4: Text("Тут профиль...").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    default: VStack {}
                }
                CustomTabView(items: [
                    CustomTabItem(index: 0, label: "menu_map", image: "map-marked-alt"),
                    CustomTabItem(index: 1, label: "menu_applications", image: "clipboard-list"),
                    CustomTabItem(index: 2, label: "menu_orders", image: "copy"),
                    CustomTabItem(index: 3, label: "menu_payments", image: "ruble-sign"),
                    CustomTabItem(index: 4, label: "menu_userprofile", image: "user"),
                ], selected: $SelectedItem)
            }
            .edgesIgnoringSafeArea(.horizontal)
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(false)
            .navigationBarTitle(self.getTitle(), displayMode: .inline)
            .navigationBarItems(trailing:
                HStack(spacing: 10) {
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
            case 0: return NSLocalizedString("title_map", comment: "")
            case 1: return NSLocalizedString("title_applications", comment: "")
            case 2: return NSLocalizedString("title_orders", comment: "")
            case 3: return NSLocalizedString("title_payments", comment: "")
            case 4: return NSLocalizedString("title_userprofile", comment: "")
            default: return ""
        }
    }
}
