//
//  InvoiceMainView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 23.01.2022.
//

import SwiftUI

struct InvoiceMainView: View, Equatable {
    @ObservedObject var mViewModel: InvoiceViewModel
    var mCurrentMode: ModeView
    var mEntityId: Int
    @ObservedObject var SelectedStatus: StatusObservable
    @Binding var ActionResult: OperationResult?
    @State var ToastMessage: String?
    
    init(entityId: Int, mode: ModeView, selectedStatus: StatusObservable , result: Binding<OperationResult?>) {
        self.mEntityId = entityId
        self.mCurrentMode = mode
        self.SelectedStatus = selectedStatus
        self._ActionResult = result
        self.mViewModel = InvoiceViewModel(entityId: entityId, include: "documents,items,files,history")
    }
    
    static func == (lhs: InvoiceMainView, rhs: InvoiceMainView) -> Bool {
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
                else if self.mViewModel.Invoice != nil {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            VStack {
                                CustomText("string_invoice_type", maxLines: 1, bold: true)
                                CustomText(self.mViewModel.Invoice!.InvoiceType!.Name)
                            }
                            .padding(.bottom, 4)
                            VStack {
                                CustomText("string_invoice_details", maxLines: 1, bold: true)
                                CustomText(String(format: NSLocalizedString("title_invoice_details", comment: ""), self.mViewModel.Invoice!.InvoiceType!.Name, self.mViewModel.Invoice!.Number!, Utils.formatDate(format: "dd MMMM yyyy", date: self.mViewModel.Invoice!.Date!)))
                            }
                            .padding(.bottom, 4)
                            VStack {
                                CustomText("string_client", maxLines: 1, bold: true)
                                if self.mViewModel.Invoice!.Document!.Order!.Application!.Company == nil {
                                    CustomText(self.mViewModel.Invoice!.Document!.Order!.Application!.User!.Profile.getUserName(), image: "user")
                                }
                                else {
                                    CustomText(self.mViewModel.Invoice!.Document!.Order!.Application!.Company!.getCompanyName(), image: "address-book")
                                }
                            }
                            .padding(.bottom, 4)
                            VStack {
                                CustomText("string_provider", maxLines: 1, bold: true)
                                CustomText(self.mViewModel.Invoice!.Document!.Order!.Company!.getCompanyName(), image: "address-book")
                            }
                            .padding(.bottom, 4)
                            VStack {
                                CustomText("string_invoice_reason", maxLines: 1, bold: true)
                                CustomText(String(format: NSLocalizedString("title_document_details", comment: ""), self.mViewModel.Invoice!.Document!.DocumentType!.Name, self.mViewModel.Invoice!.Document!.Number!, Utils.formatDate(format: "dd MMMM yyyy", date: self.mViewModel.Invoice!.Document!.Date!)))
                            }
                            .padding(.bottom, 4)
                            VStack {
                                ForEach(self.mViewModel.Invoice!.Items) { item in
                                    let index = self.mViewModel.Invoice!.Items.firstIndex(of: item)!
                                    InvoiceItemView(invoiceItem: item, index: index)
                                }
                            }
                            .padding(.bottom, 4)
                            VStack {
                                CustomText("string_description", maxLines: 1, bold: true)
                                CustomText(self.mViewModel.Invoice!.Notes!)
                            }
                        }
                        .padding(.all, 8)
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .background(Color.primary)
            .onAppear {
                if self.mViewModel.Invoice == nil {
                    self.mViewModel.loadData()
                }
            }
            .onChange(of: self.mViewModel.Invoice) { newValue in
                if (newValue != nil) {
                    if newValue!.History.count > 0 {
                        self.SelectedStatus.Status = newValue!.getStatus().Status
                    }
                }
            }
            .onChange(of: self.ActionResult) { newValue in
                if newValue != nil {
                    //TODO
                    self.ActionResult = nil
                }
            }
            ToastView($ToastMessage)
        }
    }
}
