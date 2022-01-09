//
//  ApplicationEditView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 09.01.2022.
//

import SwiftUI

struct ApplicationEditView: View {
    //@Environment(\.presentationMode) var presentationMode
    var mCurrentMode: ModeView
    var mEntityId: Int
    @State var action: Int?
    @State var selectedItems: [Int] = []
    
    init(entityId: Int, mode: ModeView) {
        self.mEntityId = entityId
        self.mCurrentMode = mode
    }
    
    var body: some View {
        NavigationView {
            TabView {
                ApplicationMainEditView(entityId: self.mEntityId, mode: self.mCurrentMode, action: $action,selectedItems: $selectedItems)
                    .background(Color.primary.edgesIgnoringSafeArea(.all))
                    .tabItem { TabBarItemView(label: "Заявка", image: "clipboard-list") }
                Text("Тут документы...")
                    .background(Color.primary.edgesIgnoringSafeArea(.all))
                    .tabItem { TabBarItemView(label: "Документы", image: "file-signature") }
                    .disabled(true)
                Text("Тут платежи...")
                    .background(Color.primary.edgesIgnoringSafeArea(.all))
                    .tabItem { TabBarItemView(label: "Платежи", image: "ruble-sign") }
                    .disabled(true)
                ApplicationHistoryView(entityId: self.mEntityId)
                    .background(Color.primary.edgesIgnoringSafeArea(.all))
                    .tabItem { TabBarItemView(label: "История", image: "history") }
                    .disabled(true)
            }
            //.accentColor(Color.secondary)
            //.navigationBarHidden(false)
            //.navigationBarTitle("Edit1 №\(self.mEntityId)", displayMode: .inline)
            //.navigationBarItems(trailing:
             //       HStack {
                        
//})
            /*.navigationBarItems(leading: HStack(spacing: 0) {
                /*NavigationLink(destination: ApplicationView(entityId: self.mEntityId, mode: ModeView.View)) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color.blue)
                        .font(Font.title.weight(.medium))
                        .offset(x: -10, y: 0)
                        .scaleEffect(0.8)
                    Text("Back")
                        .foregroundColor(Color.blue)
                        .offset(x: -5, y: 0)
                }*/
            }, trailing: HStack {
                    Image("check-circle")
                        .renderingMode(.template)
                        .foregroundColor(Color.textLight)
                        .opacity(self.isSelected ? 1 : 0)
                        .onTapGesture {
                            self.action = 3
                        }
                    Image("save")
                        .renderingMode(.template)
                        .foregroundColor(Color.textLight)
                        .onTapGesture {
                            self.action = 1
                        }
                    Image("paper-plane")
                        .renderingMode(.template)
                        .foregroundColor(Color.textLight)
                        .onTapGesture {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                })*/
        }
        //.navigationBarHidden(true)
        
    }
}

