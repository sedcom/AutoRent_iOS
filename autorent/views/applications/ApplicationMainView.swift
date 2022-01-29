//
//  ApplicationMainView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 26.12.2021.
//

import SwiftUI

struct ApplicationMainView: View, Equatable {
    @ObservedObject var mViewModel: ApplicationViewModel
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
        self.mViewModel = ApplicationViewModel(entityId: entityId, include: "companies,items,history,userprofiles")
    }
    
    static func == (lhs: ApplicationMainView, rhs: ApplicationMainView) -> Bool {
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
                else if self.mViewModel.Application != nil {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            VStack {
                                CustomText("string_client", maxLines: 1, bold: true)
                                CustomText(self.mViewModel.Application!.User!.Profile.getUserName(), image: "user")
                                if self.mViewModel.Application!.Company != nil {
                                    CustomText(self.mViewModel.Application!.Company!.getCompanyName(), image: "address-book")
                                }
                            }
                            .padding(.bottom, 4)
                            VStack {
                                CustomText("string_application_address", maxLines: 1, bold: true)
                                CustomText(self.mViewModel.Application!.Address!.getAddressName(), image: "map-marker-alt")
                            }
                            .padding(.bottom, 4)
                            VStack {
                                ForEach(self.mViewModel.Application!.Items) { item in
                                    let index = self.mViewModel.Application!.Items.firstIndex(of: item)!
                                    ApplicationItemView(applicationItem: item, index: index)
                                }
                            }
                            .padding(.bottom, 4)
                            VStack {
                                CustomText("string_description", maxLines: 1, bold: true)
                                CustomText(self.mViewModel.Application!.Notes!)
                            }
                        }
                        .padding(.all, 8)
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .background(Color.primary)
            .onAppear {
                if self.mViewModel.Application == nil {
                    self.mViewModel.loadData()
                }
            }
            .onChange(of: self.mViewModel.Application) { newValue in
                if (newValue != nil) {
                    if newValue!.History.count > 0 {
                        self.SelectedStatus.Status = newValue!.getStatus().Status
                    }
                }
            }
            .onChange(of: self.Action) { newValue in
                if newValue != nil {
                    switch(newValue!) {
                        case 2:
                            self.mViewModel.changeStatus(statusId: 2)
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
                            self.ToastMessage = NSLocalizedString("message_application_send_success", comment: "")
                            self.mViewModel.Application = Application()
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
