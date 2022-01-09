//
//  MainView2.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 09.01.2022.
//

import SwiftUI

struct MainView2: View {
    @State var tabIdx: TabMain = .tab1
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if (self.tabIdx == .tab1) {
                    MapView()
                }
                if (self.tabIdx == .tab2) {
                    //NavigationView {
                    ApplicationsView()
                    //}
                }
                if (self.tabIdx == .tab3) {
                    Text("Тут заказы...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                if (self.tabIdx == .tab4) {
                    Text("Тут счета...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                if (self.tabIdx == .tab5) {
                    Text("Тут профиль...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                MainTabView(tabIdx: $tabIdx)
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
        switch self.tabIdx {
            case .tab1: return "Карта"
            case .tab2: return "Заявки"
            case .tab3: return "Заказы"
            case .tab4: return "Платежи"
            case .tab5: return "Профиль"
            default: return ""
        }
    }
}
