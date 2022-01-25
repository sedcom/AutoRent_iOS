//
//  ApplicationMainEditView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 05.01.2022.
//

import SwiftUI

struct ApplicationMainEditView: View, Equatable {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject public var mViewModel: ApplicationViewModel
    var mCurrentMode: ModeView
    var mEntityId: Int
    @State var ShowDatePicker: Bool = false
    @State var SelectedDate: Date = Date()
    @State var SelectedUserType: Int = 1
    @StateObject var SelectedCompany = CompanyObservable()
    @StateObject var SelectedMapAddress = AddressObservable()
    @Binding var SelectedItems: [UUID]
    @Binding var Action: Int?
    @Binding var ActionResult: OperationResult?
    @State var ToastMessage: String?
    
    init(entityId: Int, mode: ModeView, action: Binding<Int?>, selectedItems: Binding<[UUID]>, result: Binding<OperationResult?>) {
        self.mEntityId = entityId
        self.mCurrentMode = mode
        self._Action = action
        self._SelectedItems = selectedItems
        self._ActionResult = result
        self.mViewModel = ApplicationViewModel(entityId: entityId, include: "companies,items,history,userprofiles")
    }
    
    static func == (lhs: ApplicationMainEditView, rhs: ApplicationMainEditView) -> Bool {
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
                    GeometryReader { geo in
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack {
                                VStack {
                                    CustomText("string_client", maxLines: 1, bold: true)
                                    Picker("", selection: $SelectedUserType) {
                                        Text("string_client_person").tag(1)
                                        Text("string_client_company").tag(2)
                                    }
                                    .pickerStyle(SegmentedPickerStyle())
                                    .padding(.bottom, 4)
                                    if self.SelectedUserType == 1 {
                                        CustomTextField(Binding(get: { self.mViewModel.Application!.User!.Profile.getUserName() }, set: { _ in }), disabled: true)
                                    }
                                    else {
                                        NavigationLink(destination: PickerCompanyView(selectedCompany: self.SelectedCompany)) {
                                            CustomTextField(Binding(get: { self.mViewModel.Application!.Company != nil ? self.mViewModel.Application!.Company!.getCompanyName() : "" }, set: { _ in }), disabled: true)
                                                .onChange(of: self.SelectedCompany.Company) { newValue in
                                                    if newValue != nil {
                                                        self.mViewModel.Application!.Company = newValue!
                                                        self.SelectedCompany.Company = nil
                                                        self.mViewModel.objectWillChange.send()
                                                    }
                                                }
                                        }
                                    }
                                }
                                .padding(.bottom, 4)
                                VStack {
                                    CustomText("string_application_address", maxLines: 1, bold: true)
                                    NavigationLink(destination: PickerMapAddressView(selectedMapAddress: self.SelectedMapAddress)) {
                                        CustomTextField(Binding(get: { self.mViewModel.Application!.Address!.getAddressName() }, set: { _ in }), disabled: true)
                                            .onChange(of: self.SelectedMapAddress.Address) { newValue in
                                                if newValue != nil {
                                                    self.mViewModel.Application!.Address = newValue!
                                                    self.mViewModel.Application!.Address!.AddressType = AddressType(id: 3, name: "")
                                                    self.SelectedMapAddress.Address = nil
                                                    self.mViewModel.objectWillChange.send()
                                                }
                                            }
                                    }
                                }
                                .padding(.bottom, 4)
                                VStack {
                                    ForEach(self.mViewModel.Application!.Items) { item in
                                        let index = self.mViewModel.Application!.Items.firstIndex { $0.id == item.id }!
                                        ApplicationItemEditView(viewModel: self.mViewModel, mode: self.mCurrentMode, index: index, showDatePicker: $ShowDatePicker, selectedDate: $SelectedDate, selectedItems: $SelectedItems)
                                    }
                                    Button("button_add", action: {
                                        self.mViewModel.addApplicationItem()
                                    })
                                    .frame(width: geo.size.width * 0.6)
                                    .padding(.all, 12)
                                    .background(Color.secondary)
                                    .foregroundColor(Color.textDark)
                                    .cornerRadius(5)
                                }
                                .padding(.bottom, 4)
                                VStack {
                                    CustomText("string_description", maxLines: 1, bold: true)
                                    TextEditor(text: Binding(get: { self.mViewModel.Application!.Notes ?? "" }, set: { self.mViewModel.Application!.Notes  = $0 }))
                                        .frame(minHeight: 100, maxHeight: 100)
                                        .background(Color.inputBackgroud)
                                        .cornerRadius(4)
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
                if self.mViewModel.Application == nil {
                    if self.mCurrentMode == ModeView.Create {
                        self.mViewModel.createItem()
                    }
                    else {
                        self.mViewModel.loadData()
                    }
                }
            }
            .onChange(of: self.mViewModel.Application) { newValue in
                if (newValue != nil) {
                    self.SelectedUserType = newValue!.Company == nil ? 1 : 2
                }
            }
            .onChange(of: self.SelectedUserType) { newValue in
                if newValue == 1 {
                    self.mViewModel.Application!.Company = nil
                }
            }
            .onChange(of: self.Action) { newValue in
                switch(newValue) {
                    case 1:
                        self.mViewModel.saveItem()
                    case 2:
                        self.mViewModel.saveItem(statusId: 2)
                    case 3:
                        self.mViewModel.removeApplicationItems(items: self.SelectedItems)
                        self.SelectedItems.removeAll()
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
