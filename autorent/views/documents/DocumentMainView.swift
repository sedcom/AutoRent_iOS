//
//  DocumentMainView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 23.01.2022.
//

import SwiftUI

struct DocumentMainView: View, Equatable {
    @ObservedObject var mViewModel: DocumentViewModel
    var mCurrentMode: ModeView
    var mEntityId: Int
    @Binding var SelectedStatus: Int?
    @Binding var ActionResult: OperationResult?
    @State var ToastMessage: String?
    
    init(entityId: Int, mode: ModeView, status: Binding<Int?>, result: Binding<OperationResult?>) {
        self.mEntityId = entityId
        self.mCurrentMode = mode
        self._SelectedStatus = status
        self._ActionResult = result
        self.mViewModel = DocumentViewModel(entityId: entityId, include: "files,orders,history")
    }
    
    static func == (lhs: DocumentMainView, rhs: DocumentMainView) -> Bool {
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
                else if self.mViewModel.Document != nil {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            VStack {
                                CustomText("string_document_type", maxLines: 1, bold: true)
                                CustomText(self.mViewModel.Document!.DocumentType!.Name)
                            }
                            .padding(.bottom, 4)
                            VStack {
                                CustomText("string_document_details", maxLines: 1, bold: true)
                                CustomText(String(format: NSLocalizedString("title_document_details", comment: ""), self.mViewModel.Document!.DocumentType!.Name, self.mViewModel.Document!.Number!, Utils.formatDate(format: "dd MMMM yyyy", date: self.mViewModel.Document!.Date!)))
                            }
                            .padding(.bottom, 4)
                            VStack {
                                CustomText("string_client", maxLines: 1, bold: true)
                                if self.mViewModel.Document!.Order!.Application!.Company == nil {
                                    CustomText(self.mViewModel.Document!.Order!.Application!.User!.Profile.getUserName(), image: "user")
                                }
                                else {
                                    CustomText(self.mViewModel.Document!.Order!.Application!.Company!.getCompanyName(), image: "address-book")
                                }
                            }
                            .padding(.bottom, 4)
                            VStack {
                                CustomText("string_provider", maxLines: 1, bold: true)
                                CustomText(self.mViewModel.Document!.Order!.Company!.getCompanyName(), image: "address-book")
                            }
                            .padding(.bottom, 4)
                            VStack {
                                CustomText("string_application_address", maxLines: 1, bold: true)
                                CustomText(self.mViewModel.Document!.Order!.Application!.Address!.getAddressName(), image: "map-marker-alt")
                            }
                            .padding(.bottom, 4)
                            VStack {
                                ForEach(self.mViewModel.Document!.Files) { file in
                                    DocumentFileView(file: file)
                                }
                            }
                            .padding(.bottom, 4)
                            VStack {
                                CustomText("string_description", maxLines: 1, bold: true)
                                CustomText(self.mViewModel.Document!.Notes!)
                            }
                        }
                        .padding(.all, 8)
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .background(Color.primary)
            .onAppear {
                if self.mViewModel.Document == nil {
                    self.mViewModel.loadData()
                }
            }
            .onChange(of: self.mViewModel.Document) { newValue in
                if (newValue != nil) {
                    self.SelectedStatus = newValue!.getStatus().Status.Id
                }
            }
            .onChange(of: self.ActionResult) { newValue in
                if newValue != nil {
                    switch(newValue!) {
                        case OperationResult.Approve:
                            self.ToastMessage = NSLocalizedString("message_document_approve_success", comment: "")
                            self.mViewModel.loadData()
                        default: print()
                    }
                    self.ActionResult = nil
                }
            }
            ToastView($ToastMessage)
        }
    }
}
