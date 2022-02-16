//
//  CompanyMainEditView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 16.02.2022.
//

import SwiftUI

struct CompanyMainEditView: View, Equatable {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject public var mViewModel: CompanyViewModel
    var mCurrentMode: ModeView
    var mEntityId: Int
    @State var ShowDatePicker: Bool = false
    @State var SelectedDate: Date = Date()
    @Binding var Action: Int?
    @Binding var ActionResult: OperationResult?
    @State var ToastMessage: String?
    
    init(entityId: Int, mode: ModeView, action: Binding<Int?>, result: Binding<OperationResult?>) {
        self.mEntityId = entityId
        self.mCurrentMode = mode
        self._Action = action
        self._ActionResult = result
        self.mViewModel = CompanyViewModel(entityId: entityId, include: "addresses,history")
    }
    
    static func == (lhs: CompanyMainEditView, rhs: CompanyMainEditView) -> Bool {
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
                    GeometryReader { geo in
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack {
                                NavigationLink(destination: EmptyView()) {}
                                VStack {
                                    
                                }
                            }
                            .padding(.all, 8)
                        }
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .background(Color.primary)
            .onAppear {
                if self.mViewModel.Company == nil {
                    if self.mCurrentMode == ModeView.Create {
                        self.mViewModel.createItem()
                    }
                    else {
                        self.mViewModel.loadData()
                    }
                }
            }
            .onChange(of: self.Action) { newValue in
                switch(newValue) {
                    case 1:
                        self.mViewModel.saveItem()
                    case 2:
                        self.mViewModel.saveItem(statusId: 2)
                    default: ()
                }
                self.Action = nil
            }
            .onChange(of: self.mViewModel.ActionResult) { newValue in
                if newValue != nil {
                    switch(newValue!) {
                        case OperationResult.Error:
                            self.ToastMessage = NSLocalizedString("message_save_error", comment: "")
                        case OperationResult.Create: ()
                            presentationMode.wrappedValue.dismiss()
                        case OperationResult.Update: ()
                            presentationMode.wrappedValue.dismiss()
                        case OperationResult.Send: ()
                            presentationMode.wrappedValue.dismiss()
                        default: ()
                    }
                    self.ActionResult = newValue
                    self.mViewModel.ActionResult = nil
                }
            }
            if self.ShowDatePicker {
                DatetimePicker(showDatePicker: $ShowDatePicker, selectedDate: $SelectedDate)
            }
            
            ToastView($ToastMessage)
        }
    }
}

