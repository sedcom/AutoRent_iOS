//
//  ApplicationMainView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 26.12.2021.
//

import SwiftUI

struct ApplicationMainView: View {
    @ObservedObject var mViewModel: ApplicationViewModel
    var mEntityId: Int
    
    init(entityId: Int) {
        self.mEntityId = entityId
        self.mViewModel = ApplicationViewModel(entityId: entityId, include: "companies,items,history,userprofiles")
    }
    
    var body: some View {
        VStack {
            VStack {
                Text("Заказчик")
                    .foregroundColor(Color.textLight)
                    .font(Font.headline.weight(.bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(1)
                Text(self.mViewModel.Application?.Notes ?? "")
            }
            .padding(.all, 8)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.primary)
        .navigationBarHidden(false)
        .onAppear {
            self.mViewModel.loadData()
        }
    }
}
