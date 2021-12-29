//
//  ApplicationHistoryView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 28.12.2021.
//

import SwiftUI

struct ApplicationHistoryView: View {
    @ObservedObject var mViewModel: ApplicationViewModel
    var mEntityId: Int
    
    init(entityId: Int) {
        self.mEntityId = entityId
        self.mViewModel = ApplicationViewModel(entityId: entityId, include: "history")
    }
    
    var body: some View {
        VStack {
            List {
                if self.mViewModel.Application != nil {
                    ForEach(self.mViewModel.Application!.History) { history in
                        VStack {
                            VStack {
                                HStack {
                                    HStack {
                                        Image("calendar-alt")
                                            .renderingMode(.template)
                                            .foregroundColor(Color.textLight)
                                        Text(Utils.formatDate(format: "dd.MM.yyyy HH:mm:ss", date: history.CreatedDate))
                                            .foregroundColor(Color.textLight)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .lineLimit(1)
                                    }
                                    Text(history.Status.Name)
                                        .foregroundColor(Color.textLight)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .lineLimit(1)
                                }
                            }
                            .padding(.all, 8)
                        }
                        .background(Color.primaryDark)
                        .cornerRadius(5)
                    }
                    .listRowBackground(Color.primary)
                    .listRowInsets(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 10))
                }
            }
            .listStyle(PlainListStyle())
            .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 0))
        }
        .background(Color.primary)
        //.navigationBarHidden(true)
        .onAppear {
            self.mViewModel.loadData()
        }
    }
}
