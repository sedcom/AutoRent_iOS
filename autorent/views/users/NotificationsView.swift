//
//  NotificationsView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 23.01.2022.
//

import SwiftUI

struct NotificationsView: View  {
    @ObservedObject var mViewModel: NotificationsViewModel
    @State var ToastMessage: String?
     
    init() {
        let user = AuthenticationService.getInstance().getCurrentUser()
        self.mViewModel = NotificationsViewModel(userId: user!.Id, maxItems: 10, skipCount: 0, orderBy: "Id desc", include: "", filter: "")
    }

    var body: some View {
        VStack {
            if self.mViewModel.IsLoading == true && self.mViewModel.mSkipCount == 0 {
                LoadingView()
            }
            else if self.mViewModel.IsError {
                ErrorView()
            }
            else if self.mViewModel.Data.Elements.count == 0 {
                EmptyView()
            }
            else {
                VStack {
                    List {
                        ForEach(self.mViewModel.Data.Elements) { notification in
                            VStack {
                                if notification.Id == 0 {
                                    LoadingRowView()
                                }
                                else {
                                    NotificationsRowView(notification)
                                }
                            }
                            .listRowBackground(Color.primary)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .onAppear {
                                //TODO
                                if self.mViewModel.IsLoading == false {
                                    if self.mViewModel.Data.Elements.count < self.mViewModel.Data.Total {
                                        if  notification == self.mViewModel.Data.Elements.last {
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
                }
                .background(Color.primary)
            }
        }
        .edgesIgnoringSafeArea(.horizontal)
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(false)
        .navigationBarTitle(NSLocalizedString("title_notifications", comment: ""), displayMode: .inline)
        .onAppear {
            if self.mViewModel.Data.Elements.count == 0 {
                self.mViewModel.clearData()
                self.mViewModel.loadData()
            }
        }
    }
}

