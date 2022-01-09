//
//  ApplicationTabView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 09.01.2022.
//

import SwiftUI

enum TabApplication {
    case tab1, tab2, tab3, tab4
}

struct ApplicationTabView: View {
    @Binding var tabIdx: TabApplication
    
    var body: some View {
        HStack {
            Group {
                Button (action: { self.tabIdx = .tab1}) {
                    VStack{
                        Image("clipboard-list")
                            .renderingMode(.template)
                            .foregroundColor(self.tabIdx == .tab1 ? Color.secondary : Color.textLight)
                        Text("Заявка")
                            .foregroundColor(self.tabIdx == .tab1 ? Color.secondary : Color.textLight)
                            .font(.system(size: 16))
                            .font(Font.headline.weight(.bold))
                    }
                }
                Spacer()
                Button (action: { self.tabIdx = .tab2}) {
                    VStack{
                        Image("file-signature")
                            .renderingMode(.template)
                            .foregroundColor(self.tabIdx == .tab2 ? Color.secondary : Color.textLight)
                        Text("Документы")
                            .foregroundColor(self.tabIdx == .tab2 ? Color.secondary : Color.textLight)
                            .font(.system(size: 16))
                            .font(Font.headline.weight(.bold))
                    }
                }
                Spacer()
                Button (action: { self.tabIdx = .tab3}) {
                    VStack{
                        Image("ruble-sign")
                            .renderingMode(.template)
                            .foregroundColor(self.tabIdx == .tab3 ? Color.secondary : Color.textLight)
                        Text("Платежи")
                            .foregroundColor(self.tabIdx == .tab3 ? Color.secondary : Color.textLight)
                            .font(.system(size: 16))
                            .font(Font.headline.weight(.bold))
                    }
                }
                Spacer()
                Button (action: { self.tabIdx = .tab4}) {
                    VStack{
                        Image("history")
                            .renderingMode(.template)
                            .foregroundColor(self.tabIdx == .tab4 ? Color.secondary : Color.textLight)
                        Text("История")
                            .foregroundColor(self.tabIdx == .tab4 ? Color.secondary : Color.textLight)
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


