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
    @ObservedObject var SelectedStatus: StatusObservable
    @Binding var Action: Int?
    @Binding var ActionResult: OperationResult?
    @State var ToastMessage: String?
    @State var ShowBottomSheet: Bool = false
    
    init(entityId: Int, mode: ModeView, selectedStatus: StatusObservable, action: Binding<Int?>, result: Binding<OperationResult?>) {
        self.mEntityId = entityId
        self.mCurrentMode = mode
        self.SelectedStatus = selectedStatus
        self._Action = action
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
                                    NavigationLink(destination: FileView(file: file)) {
                                        DocumentFileView(file: file)
                                    }
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
                    if newValue!.History.count > 0 {
                        self.SelectedStatus.Status = newValue!.getStatus().Status
                    }
                }
            }
            .onChange(of: self.Action) { newValue in
                if (newValue != nil) {
                    switch(newValue!) {
                        case 1:
                            self.ShowBottomSheet.toggle()
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
                        case OperationResult.Accept:
                            self.ToastMessage = NSLocalizedString("message_document_accept_success", comment: "")
                        case OperationResult.Reject:
                            self.ToastMessage = NSLocalizedString("message_document_reject_success", comment: "")
                        default: ()
                    }
                    self.mViewModel.Document = Document()
                    self.mViewModel.loadData()
                    self.ActionResult = nil
                }
            }
            .onChange(of: self.mViewModel.ActionResult) { newValue in
                if newValue != nil {
                    self.ActionResult = newValue
                    self.mViewModel.ActionResult = nil
                }
            }
            BottomSheet(show: $ShowBottomSheet, maxHeight: 120) {
                VStack {
                    CustomText("menu_document_approve", bold: true, color: Color.textDark, image: "iconmonstr-check")
                        .padding(.bottom, 8)
                        .onTapGesture {
                            self.mViewModel.changeStatus(statusId: 3)
                            self.ShowBottomSheet = false
                        }
                    CustomText("menu_document_reject", bold: true, color: Color.textDark, image: "iconmonstr-forbidden")
                        .onTapGesture {
                            self.mViewModel.changeStatus(statusId: 4)
                            self.ShowBottomSheet = false
                        }
                }
                .padding(.all, 12)
            }
            ToastView($ToastMessage)
        }
    }
}

