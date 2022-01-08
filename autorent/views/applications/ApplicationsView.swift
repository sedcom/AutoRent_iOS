//
//  ApplicationsView.swift
//  autorent
//
//  Created by Semyon Kravchenko on 27.11.2021.
//

import SwiftUI

struct ApplicationsView: View {
    @ObservedObject var mViewModel: ApplicationsViewModel
    @State var mCurrentFilter: Int
    
    init() {
        self.mCurrentFilter = 1
        self.mViewModel = ApplicationsViewModel(userId: 1, maxItems: 10, skipCount: 0, orderBy: "Id desc", include: "companies,items,history,userprofiles", filter: "")
    }

    var body: some View {
        VStack {
            if self.mViewModel.IsLoading == true && self.mViewModel.mSkipCount == 0 {
                LoadingView()
            }
            else if self.mViewModel.IsError {
                ErrorView()
            }
            else {
                VStack (spacing: 0) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack () {
                            Button("status_all", action: { self.setFilter(filterIndex: 1, filter: "") })
                                .buttonStyle(FilterButtonStyle(selected: self.mCurrentFilter == 1))
                            Button("status_draft", action: { self.setFilter(filterIndex: 2, filter: "statusId==1") })
                                .buttonStyle(FilterButtonStyle(selected: self.mCurrentFilter == 2))
                            Button("status_application_process", action: { self.setFilter(filterIndex: 3, filter: "statusId==2,3,4,5,6,8") })
                                .buttonStyle(FilterButtonStyle(selected: self.mCurrentFilter == 3))
                            Button("status_application_completed", action: { self.setFilter(filterIndex: 4, filter: "statusId==7") })
                                .buttonStyle(FilterButtonStyle(selected: self.mCurrentFilter == 4))
                            Button("status_application_closed", action: { self.setFilter(filterIndex: 5, filter: "statusId==9,10") })
                                .buttonStyle(FilterButtonStyle(selected: self.mCurrentFilter == 5))
                        }
                        .padding(.all, 8)
                    }
                    .background(Color.primaryDark)
                    .edgesIgnoringSafeArea(.horizontal)
                    if self.mViewModel.Data.Elements.count == 0 {
                        EmptyView()
                    }
                    else {
                        ZStack {
                            List {
                                ForEach(self.mViewModel.Data.Elements) { application in
                                    VStack {
                                        if application.Id == 0 {
                                            LoadingRowView()
                                        }
                                        else {
                                            NavigationLink(destination: ApplicationView(entityId: application.Id, mode: ModeView.View))  {
                                                ApplicationsRowView(application)
                                            }
                                        }
                                    }
                                    .listRowBackground(Color.primary)
                                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: -20))
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
                            }
                            .listStyle(PlainListStyle())
                            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                            GeometryReader { geo in
                                Image("plus")
                                    .renderingMode(.template)
                                    .resizable()
                                    .background(Circle().fill(Color.secondary).frame(width: 60, height: 60))
                                    .foregroundColor(Color(UIColor.darkGray))
                                    .frame(width: 30, height: 30)
                                    .offset(x: geo.size.width - 50, y: geo.size.height - 50)
                                NavigationLink(destination: ApplicationView(entityId: 0, mode: ModeView.Create)) {
                                        Circle().frame(width: 60, height: 60).hidden()
                                    }
                                    .offset(x: geo.size.width - 65, y: geo.size.height - 65)
                            }
                        }
                    }
                }
                .background(Color.primary)
            }
        }
        .onAppear {
            if self.mViewModel.Data.Elements.count == 0 {
                self.mViewModel.clearData()
                self.mViewModel.loadData()
            }
        }
    }
    
    private func setFilter(filterIndex: Int, filter: String) {
        self.mCurrentFilter = filterIndex
        self.mViewModel.setFilter(filter)
        self.mViewModel.clearData()
        self.mViewModel.loadData()
    }
}
