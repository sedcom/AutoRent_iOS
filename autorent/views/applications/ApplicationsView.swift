//
//  ApplicationsView.swift
//  autorent
//
//  Created by Semyon Kravchenko on 27.11.2021.
//

import SwiftUI

struct ApplicationsView: View, Equatable {
    @ObservedObject var mViewModel: ApplicationsViewModel
    @State var mCurrentFilter: Int
    @State var ActionResult: OperationResult?
    @State var Refresh: Bool?
    @State var ToastMessage: String?
    
    init() {
        self.mCurrentFilter = 1
        self.mViewModel = ApplicationsViewModel(userId: 1, maxItems: 10, skipCount: 0, orderBy: "Id desc", include: "companies,items,history,userprofiles", filter: "")
    }

    static func == (lhs: ApplicationsView, rhs: ApplicationsView) -> Bool {
        return true
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
                                            NavigationLink(destination: ApplicationView(entityId: application.Id, mode: ModeView.View, refresh: $Refresh))  {
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
                            ZStack {
                                NavigationLink(destination: ApplicationEditView(entityId: 0, mode: ModeView.Create, result: $ActionResult)) {
                                    ZStack {
                                        Circle().fill(Color.secondary)
                                        Image("plus")
                                            .renderingMode(.template)
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(Color(UIColor.darkGray))
                                    }
                                }
                                .frame(width: 60, height: 60)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                            .offset(x: -10, y: -10)
                            ZStack {
                                ToastView($ToastMessage)
                            }
                        }
                    }
                }
                .background(Color.primary)
            }
        }
        .onAppear {
            if self.mViewModel.Data.Elements.count == 0 || self.Refresh ?? false {
                self.Refresh = nil
                self.loadData()
            }
        }
        .onChange(of: self.ActionResult) { newValue in
            if newValue != nil {
                switch(newValue!) {
                    case OperationResult.Create:
                        self.ToastMessage = NSLocalizedString("message_save_success", comment: "")
                    case OperationResult.Update:
                        self.ToastMessage = NSLocalizedString("message_save_success", comment: "")
                    case OperationResult.Send:
                        self.ToastMessage = NSLocalizedString("message_application_send_success", comment: "")
                    default: ()
                }
                self.Refresh = true
                self.ActionResult = nil
            }
        }
        .onChange(of: self.Refresh) { newValue in
            if newValue != nil {

            }
        }
    }
 
    private func loadData() {
        self.mViewModel.clearData()
        self.mViewModel.loadData()
    }
    
    private func setFilter(filterIndex: Int, filter: String) {
        self.mCurrentFilter = filterIndex
        self.mViewModel.setFilter(filter)
        self.loadData()
    }
}
