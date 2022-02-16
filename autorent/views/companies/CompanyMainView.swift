//
//  CompanyMainView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 16.02.2022.
//

import SwiftUI

struct CompanyMainView: View, Equatable {
    @ObservedObject var mViewModel: CompanyViewModel
    var mCurrentMode: ModeView
    var mEntityId: Int
    @ObservedObject var SelectedStatus: StatusObservable
    @Binding var Action: Int?
    @Binding var ActionResult: OperationResult?
    @State var ToastMessage: String?
    
    init(entityId: Int, mode: ModeView, selectedStatus: StatusObservable, action: Binding<Int?>, result: Binding<OperationResult?>) {
        self.mEntityId = entityId
        self.mCurrentMode = mode
        self.SelectedStatus = selectedStatus
        self._Action = action
        self._ActionResult = result
        self.mViewModel = CompanyViewModel(entityId: entityId, include: "addresses,history")
    }
    
    static func == (lhs: CompanyMainView, rhs: CompanyMainView) -> Bool {
        return true
    }
    
    var body: some View {
        ZStack {
            VStack {
                if self.mViewModel.IsLoading == true  {
                    LoadingView()
                }
                else if self.mViewModel.IsError {
                    ErrorView()
                }
                else if self.mViewModel.Company != nil {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            HStack {
                                Image("address-book")
                                    .resizable()
                                    .frame(width: 30, height: 35)
                                    .foregroundColor(Color.textLight)
                                VStack {
                                    CustomText(self.mViewModel.Company!.getCompanyName(), bold: true)
                                    CustomText(self.mViewModel.Company!.CompanyType!.Name)
                                }
                            }
                            .padding(.bottom, 4)
                            VStack {
                                CustomText("string_company_information", maxLines: 1, bold: true)
                                CustomText(String(format: "%@ %@", NSLocalizedString("string_company_inn", comment: ""), self.mViewModel.Company!.INN ?? ""))
                                CustomText(String(format: "%@ %@", NSLocalizedString("string_company_kpp", comment: ""), self.mViewModel.Company!.KPP ?? ""))
                            }
                            .padding(.bottom, 4)
                            VStack {
                                CustomText("string_company_contacts", maxLines: 1, bold: true)
                                CustomText(self.mViewModel.Company!.MobilePhone ?? "", image: "iconmonstr-phone")
                                CustomText(self.mViewModel.Company!.Email ?? "", image: "iconmonstr-email")
                            }
                            .padding(.bottom, 4)
                            HStack {
                                Image("map-marker-alt")
                                    .resizable()
                                    .frame(width: 15, height: 20)
                                    .foregroundColor(Color.textLight)
                                ForEach(self.mViewModel.Company!.Addresses) { address in
                                    VStack {
                                        CustomText(address.AddressType.Name, bold: true)
                                        CustomText(address.getAddressName())
                                    }
                                }
                            }
                            .padding(.bottom, 4)
                        }
                        .padding(.all, 8)
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .background(Color.primary)
            .onAppear {
                if self.mViewModel.Company == nil {
                    self.mViewModel.loadData()
                }
            }
            .onChange(of: self.mViewModel.Company) { newValue in
                if (newValue != nil) {
                    if newValue!.History.count > 0 {
                        self.SelectedStatus.Status = newValue!.getStatus().Status
                    }
                }
            }
            .onChange(of: self.Action) { newValue in
                if newValue != nil {
                    switch(newValue!) {
                        case 2: ()
                        default: ()
                    }
                    self.Action = nil
                }
            }
            .onChange(of: self.ActionResult) { newValue in
                if newValue != nil {
                    switch(newValue!) {
                        case OperationResult.Error:
                            self.ToastMessage = NSLocalizedString("message_save_error", comment: "")
                        case OperationResult.Update:
                            self.ToastMessage = NSLocalizedString("message_save_success", comment: "")
                            self.mViewModel.loadData()
                        case OperationResult.Send:
                            self.ToastMessage = NSLocalizedString("message_company_send_success", comment: "")
                            self.mViewModel.Company = Company()
                            self.mViewModel.loadData()
                        default: ()
                    }
                    self.ActionResult = nil
                }
            }
            .onChange(of: self.mViewModel.ActionResult) { newValue in
                if newValue != nil {
                    self.ActionResult = newValue
                    self.mViewModel.ActionResult = nil
                }
            }
           
            ToastView($ToastMessage)
        }
    }
}
