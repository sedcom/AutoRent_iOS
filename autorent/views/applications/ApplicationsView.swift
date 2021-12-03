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
        self.mViewModel = ApplicationsViewModel(maxItems: 10, skipCount: 0, orderBy: "Id desc", include: "companies,items,history,userprofiles", filters: "")
        UITableView.appearance().backgroundColor = UIColor(Color.primary)
        UITableViewCell.appearance().selectedBackgroundView = UIView()
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
                    }
                    .background(Color.primary)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack () {
                            Button(NSLocalizedString("status_all", comment: ""), action: {
                                self.mViewModel.mFilters = ""
                                self.mViewModel.clearData()
                                self.mViewModel.loadData()
                            }).buttonStyle(FilterButtonStyle())
                            Button(NSLocalizedString("status_draft", comment: ""), action: {
                                self.mViewModel.mFilters = "statusId==1"
                                self.mViewModel.clearData()
                                self.mViewModel.loadData()
                            }).buttonStyle(FilterButtonStyle())
                            Button(NSLocalizedString("status_application_process", comment: ""), action: {
                                self.mViewModel.mFilters = "statusId==2,3,4,5,6,8"
                                self.mViewModel.clearData()
                                self.mViewModel.loadData()
                            }).buttonStyle(FilterButtonStyle())
                            Button(NSLocalizedString("status_application_completed", comment: ""), action: {
                                self.mViewModel.mFilters = "statusId==7"
                                self.mViewModel.clearData()
                                self.mViewModel.loadData()
                            }).buttonStyle(FilterButtonStyle())
                            Button(NSLocalizedString("status_application_closed", comment: ""), action: {
                                self.mViewModel.mFilters = "statusId==9,10"
                                self.mViewModel.clearData()
                                self.mViewModel.loadData()
                            }).buttonStyle(FilterButtonStyle())
                        }
                        .padding(.all, 8)
                    }
                    .background(Color.primaryDark)
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
                                }
                                .onAppear {
                                    //TODO
                                    if self.mViewModel.IsLoading == false {
                                        if self.mViewModel.Data.Elements.count < self.mViewModel.Data.Total {
                                            if  application == self.mViewModel.Data.Elements.last {
                                                self.mViewModel.mSkipCount = self.mViewModel.Data.Elements.count
                                                self.mViewModel.loadData()
                                           }
                                        }
                                    }
                                }
                                
                            }
                            .listRowBackground(Color.primary)
                            .listRowInsets(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 10))
                        }
                        .listStyle(PlainListStyle())
                        .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 0))
                    }
                }
                .background(Color.primary)
                .navigationBarHidden(true)
            }
        }.onAppear {
            self.mViewModel.clearData()
            self.mViewModel.loadData()
        }
    }
}
