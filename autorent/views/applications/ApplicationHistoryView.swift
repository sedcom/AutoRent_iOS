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
            if self.mViewModel.IsLoading == true  {
                LoadingView()
            }
            else if self.mViewModel.IsError {
                ErrorView()
            }
            else {
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
                            .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
                        }
                        .listRowBackground(Color.primary)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                }
                .listStyle(PlainListStyle())
                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
            }
        }
        .background(Color.primary)
        .onAppear {
            self.mViewModel.loadData()        
        }
    }
}
