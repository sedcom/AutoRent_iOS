//
//  ApplicationsView.swift
//  autorent
//
//  Created by Semyon Kravchenko on 27.11.2021.
//

import SwiftUI

struct ApplicationsView: View {
    @ObservedObject var mViewModel: ApplicationsViewModel
    
    init() {
        self.mViewModel = ApplicationsViewModel(maxItems: 10, skipCount: 0)
        UITableView.appearance().backgroundColor = UIColor(Color.primary)
        UITableView.appearance().separatorStyle = .none
    }

    var body: some View {
        NavigationView {
            if self.mViewModel.IsLoading == true && self.mViewModel.mSkipCount == 0 {
                LoadingView()
            }
            else if self.mViewModel.IsError {
                ErrorView()
            }
            else {
                VStack (spacing: 0){
                    VStack {
                        Text("Заявки на услуги")
                            .foregroundColor(Color.textLight)
                            .padding(.all, 8)
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }.background(Color.primary)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack () {
                            ButtonFilter(label: "Все")
                            ButtonFilter(label: "Черновики")
                            ButtonFilter(label: "В процессе")
                            ButtonFilter(label: "Выполнены")
                            ButtonFilter(label: "Завершены")
                        }.padding(.all, 8)
                    }.background(Color.primaryDark)
                    if self.mViewModel.Data.Elements.count == 0 {
                        EmptyView()
                    }
                    else {
                        List {
                            ForEach(self.mViewModel.Data.Elements) { application in
                                VStack {
                                    if application.Id == 0 {
                                        LoadingRowView()
                                    }
                                    else {
                                        ApplicationsRowView(application)
                                    }
                                }.onAppear {
                                    if self.mViewModel.IsLoading == false {
                                        if self.mViewModel.Data.Elements.count < self.mViewModel.Data.Total {
                                            if application == self.mViewModel.Data.Elements.last {
                                                self.mViewModel.mSkipCount = self.mViewModel.Data.Elements.count
                                                self.mViewModel.loadData()
                                           }
                                        }
                                    }
                                }
                            }.listRowBackground(Color.primaryDark)
                        }
                    }
                }.navigationBarHidden(true)
            }
        }.onAppear {
            self.mViewModel.clearData()
            self.mViewModel.loadData()
        }
    }
}
