//
//  ApplicationView.swift
//  autorent
//
//  Created by Semyon Kravchenko on 29.11.2021.
//

import SwiftUI

struct ApplicationView: View {
    var mCurrentMode: ModeView
    var mEntityId: Int
    @State var action: Int?
    @State var isSelected: Bool = false
    @State var selectedItems: [Int] = []
    @State var selection: Int?
    
    init(entityId: Int, mode: ModeView) {
        self.mEntityId = entityId
        self.mCurrentMode = mode
    }
    
    var body: some View {
        VStack {
            TabView {
                ApplicationMainView(entityId: self.mEntityId, mode: self.mCurrentMode)
                    .background(Color.primary.edgesIgnoringSafeArea(.all))
                    .tabItem { TabBarItemView(label: "Заявка", image: "clipboard-list") }
                Text("Тут документы...")
                    .background(Color.primary.edgesIgnoringSafeArea(.all))
                    .tabItem { TabBarItemView(label: "Документы", image: "file-signature") }
                Text("Тут платежи...")
                    .background(Color.primary.edgesIgnoringSafeArea(.all))
                    .tabItem { TabBarItemView(label: "Платежи", image: "ruble-sign") }
                ApplicationHistoryView(entityId: self.mEntityId)
                    .background(Color.primary.edgesIgnoringSafeArea(.all))
                    .tabItem { TabBarItemView(label: "История", image: "history") }
            }
            .accentColor(Color.secondary)
            /*.navigationBarHidden(true)
            .navigationBarTitle("App2 №\(self.mEntityId)", displayMode: .inline)
            .navigationBarItems(trailing:
                    HStack {
                        if self.mCurrentMode == ModeView.View {
                            NavigationLink(destination: ApplicationEditView(entityId: self.mEntityId, mode: ModeView.Edit)) {
                                Image("iconmonstr-edit")
                                    .renderingMode(.template)
                                    .foregroundColor(Color.textLight)
                            }
                        }
                    })*/
        }
        .navigationBarHidden(false)
        .navigationBarTitle("App №\(self.mEntityId)", displayMode: .inline)
        .navigationBarItems(trailing:
                HStack {
                    if self.mCurrentMode == ModeView.View {
                        NavigationLink(destination: ApplicationEditView2(entityId: self.mEntityId, mode: ModeView.Edit)) {
                            Image("iconmonstr-edit")
                                .renderingMode(.template)
                                .foregroundColor(Color.textLight)
                                //.onTapGesture {
                                //    self.selection = 2
                                //}
                        }
                    }
                })
    }
}
