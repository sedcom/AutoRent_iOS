//
//  MainView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 09.01.2022.
//

import SwiftUI

enum OperationResult {
   case Error, Create, Update, Send, Accept, Reject, Complete, Cancel
}

struct MainView: View {
    @State private var SelectedTab: Int = 0
    @State var Action: Int?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                switch self.SelectedTab {
                    case 0: MapWrapperView()
                    case 1: ApplicationsView()
                    case 2: OrdersView()
                    case 3: InvoicesView()
                    case 4: UserProfileView()
                    default: VStack {}
                }
                CustomTabView(items: [
                    CustomTabItem(index: 0, label: "menu_map", image: "map-marked-alt"),
                    CustomTabItem(index: 1, label: "menu_applications", image: "clipboard-list"),
                    CustomTabItem(index: 2, label: "menu_orders", image: "copy"),
                    CustomTabItem(index: 3, label: "menu_payments", image: "ruble-sign"),
                    CustomTabItem(index: 4, label: "menu_userprofile", image: "user"),
                ], selected: $SelectedTab)
                
                NavigationLink(destination: NotificationsView(), tag: 2, selection: $Action)  { }
            }
            .edgesIgnoringSafeArea(.horizontal)
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(false)
            .navigationBarTitle(self.getTitle(), displayMode: .inline)
            .navigationBarItems(trailing:
                HStack(spacing: 10) {
                    /*Image("comment-dots")
                        .renderingMode(.template)
                        .foregroundColor(Color.textLight)*/
                    Image("bell")
                        .renderingMode(.template)
                        .foregroundColor(Color.textLight)
                        .onTapGesture {
                            self.Action = 2
                        }
                })
        }
    }
    
    func getTitle() -> String {
        switch self.SelectedTab {
            case 0: return NSLocalizedString("title_map", comment: "")
            case 1: return NSLocalizedString("title_applications", comment: "")
            case 2: return NSLocalizedString("title_orders", comment: "")
            case 3: return NSLocalizedString("title_payments", comment: "")
            case 4: return NSLocalizedString("title_userprofile", comment: "")
            default: return ""
        }
    }
}
