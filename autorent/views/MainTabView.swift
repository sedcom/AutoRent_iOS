//
//  MainTabView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 09.01.2022.
//

import SwiftUI

enum TabMain {
    case tab1, tab2, tab3, tab4, tab5
}

struct MainTabView: View {
    @Binding var tabIdx: TabMain
    
    var body: some View {
        HStack {
            Group {
                Button (action: { self.tabIdx = .tab1}) {
                    VStack{
                        Image("map-marked-alt")
                            .renderingMode(.template)
                            .foregroundColor(self.tabIdx == .tab1 ? Color.secondary : Color.textLight)
                        Text("menu_map")
                            .foregroundColor(self.tabIdx == .tab1 ? Color.secondary : Color.textLight)
                            .font(.system(size: 16))
                            .font(Font.headline.weight(.bold))
                    }
                }
                Spacer()
                Button (action: { self.tabIdx = .tab2}) {
                    VStack{
                        Image("clipboard-list")
                            .renderingMode(.template)
                            .foregroundColor(self.tabIdx == .tab2 ? Color.secondary : Color.textLight)
                        Text("Заявки")
                            .foregroundColor(self.tabIdx == .tab2 ? Color.secondary : Color.textLight)
                            .font(.system(size: 16))
                            .font(Font.headline.weight(.bold))
                    }
                }
                Spacer()
                Button (action: { self.tabIdx = .tab3}) {
                    VStack{
                        Image("copy")
                            .renderingMode(.template)
                            .foregroundColor(self.tabIdx == .tab3 ? Color.secondary : Color.textLight)
                        Text("Заказы")
                            .foregroundColor(self.tabIdx == .tab3 ? Color.secondary : Color.textLight)
                            .font(.system(size: 16))
                            .font(Font.headline.weight(.bold))
                    }
                }
                Spacer()
                Button (action: { self.tabIdx = .tab4}) {
                    VStack{
                        Image("ruble-sign")
                            .renderingMode(.template)
                            .foregroundColor(self.tabIdx == .tab4 ? Color.secondary : Color.textLight)
                        Text("Платежи")
                            .foregroundColor(self.tabIdx == .tab4 ? Color.secondary : Color.textLight)
                            .font(.system(size: 16))
                            .font(Font.headline.weight(.bold))
                    }
                }
                Spacer()
                Button (action: { self.tabIdx = .tab5}) {
                    VStack{
                        Image("user")
                            .renderingMode(.template)
                            .foregroundColor(self.tabIdx == .tab5 ? Color.secondary : Color.textLight)
                        Text("Профиль")
                            .foregroundColor(self.tabIdx == .tab5 ? Color.secondary : Color.textLight)
                            .font(.system(size: 16))
                            .font(Font.headline.weight(.bold))
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20))
        .background(Color.primaryDark)
    }
}

