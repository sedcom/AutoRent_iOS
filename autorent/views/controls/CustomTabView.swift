//
//  CustomTabView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 13.01.2022.
//

import SwiftUI

struct CustomTabView: View {
    var mItems: [CustomTabItem]
    @Binding var SelectedTab: Int
    
    init(items: [CustomTabItem], selected: Binding<Int>) {
        self.mItems = items
        self._SelectedTab = selected
    }
    
    var body: some View {
        HStack {
            Group {
                ForEach(0..<self.mItems.count) { index in
                    let item = self.mItems[index]
                    Button (action: {
                        if item.Disabled == false {
                            self.SelectedTab = item.Index
                        }
                    }) {
                        VStack {
                            Image(item.Image)
                                .renderingMode(.template)
                                .foregroundColor(item.Disabled == false ? self.SelectedTab  == item.Index ? Color.secondary : Color.textLight :  Color.textDark)
                            Text(LocalizedStringKey(item.Label))
                                .foregroundColor(item.Disabled == false ? self.SelectedTab  == item.Index ? Color.secondary : Color.textLight :  Color.textDark)
                                .font(.system(size: 16))
                                .font(Font.headline.weight(.bold))
                                .lineLimit(1)
                        }
                    }
                    if index < self.mItems.count - 1 {
                        Spacer()
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20))
        .background(Color.primaryDark)
    }
}

