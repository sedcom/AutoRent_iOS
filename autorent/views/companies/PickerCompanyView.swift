//
//  PickerCompanyView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 21.01.2022.
//

import SwiftUI

struct PickerCompanyView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var mViewModel: CompaniesViewModel
    @ObservedObject var SelectedCompany: CompanyObservable
    @State var mSelectedItem: Company?

    init(selectedCompany: CompanyObservable) {
        self.SelectedCompany = selectedCompany
        self.mViewModel = CompaniesViewModel(userId: 1, maxItems: 10, skipCount: 0, orderBy: "Name asc", include: "", filter: "")
    }
    
    var body: some View {
        VStack {
            if self.mViewModel.IsLoading == true {
                LoadingView()
            }
            else if self.mViewModel.IsError {
                ErrorView()
            }
            else {
                if self.mViewModel.Data.Elements.count == 0 {
                    EmptyView()
                        .onTapGesture {
                            self.mViewModel.clearData()
                            self.mViewModel.loadData()
                        }
                }
                else {
                    VStack {
                        List {
                            ForEach(self.mViewModel.Data.Elements) { company in
                                VStack {
                                    if company.Id == 0 {
                                        LoadingRowView()
                                    }
                                    else {
                                        Text(company.getCompanyName())
                                            .padding(.all, 8)
                                            .foregroundColor(self.mSelectedItem == company ? Color.textDark : Color.textLight)
                                            .onTapGesture {
                                                self.mSelectedItem = company
                                            }
                                    }
                                }
                                .listRowBackground(self.mSelectedItem == company ? Color.secondary : Color.primaryDark)
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .onAppear {
                                    //TODO
                                    if self.mViewModel.IsLoading == false {
                                        if self.mViewModel.Data.Elements.count < self.mViewModel.Data.Total {
                                            if  company == self.mViewModel.Data.Elements.last {
                                                self.mViewModel.mSkipCount = self.mViewModel.Data.Elements.count
                                                self.mViewModel.loadData()
                                           }
                                        }
                                    }
                                }
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                    .background(Color.primaryDark)
                }
            }
        }
        .background(Color.primary.edgesIgnoringSafeArea(.all))
        .navigationBarHidden(false)
        .navigationBarTitle(NSLocalizedString("title_picker_usercompanies", comment: ""), displayMode: .inline)
        .navigationBarItems(trailing:
            HStack {
                Image("check-circle")
                    .renderingMode(.template)
                    .foregroundColor(Color.textLight)
                    .onTapGesture {
                        if self.mSelectedItem != nil {
                            self.SelectedCompany.Company = self.mSelectedItem!
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
            }
        )
        .onAppear {
            if self.mViewModel.Data.Elements.count == 0 {
                self.mViewModel.clearData()
                self.mViewModel.loadData()
            }
        }
    }
}