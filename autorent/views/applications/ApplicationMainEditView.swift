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
    @Binding var SelectedItems: [UUID]
    @Binding var Action: Int?
    @Binding var ActionResult: OperationResult?
    @State var ShowToast: Bool = false
    @State var mToastText: String = ""
    
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
                                    Text("Заказчик")
                                        .foregroundColor(Color.textLight)
                                        .font(Font.headline.weight(.bold))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .lineLimit(1)
                                    HStack {
                                        Image("user")
                                            .renderingMode(.template)
                                            .foregroundColor(Color.textLight)
                                        Text("")
                                            .foregroundColor(Color.textLight)
                                            .fixedSize(horizontal: false, vertical: true)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .padding(.bottom, 4)
                                    Text("Место оказания услуг")
                                        .foregroundColor(Color.textLight)
                                        .font(Font.headline.weight(.bold))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .lineLimit(1)
                                    TextField("", text: Binding(get: { self.mViewModel.Application!.Address.getAddressName() }, set: { _ in }))
                                        .frame(minHeight: 30, maxHeight: 30)
                                        .background(Color.inputBackgroud)
                                        .cornerRadius(4)
                                        .disabled(true)
                                        .padding(.bottom, 4)
                                    ForEach(self.mViewModel.Application!.Items) { item in
                                        let index = self.mViewModel.Application!.Items.firstIndex { $0.id == item.id }!
                                        ApplicationItemEditView(viewModel: self.mViewModel, mode: self.mCurrentMode, index: index, showDatePicker: $ShowDatePicker, selectedDate: $SelectedDate, selectedItems: $SelectedItems)
                                    }
                                    Button("Add", action: {
                                        self.mViewModel.addApplicationItem()
                                    })
                                    .frame(width: geo.size.width * 0.6)
                                    .padding(.all, 12)
                                    .background(Color.secondary)
                                    .foregroundColor(Color.textDark)
                                    .cornerRadius(5)
                                    Text("Описание")
                                        .foregroundColor(Color.textLight)
                                        .font(Font.headline.weight(.bold))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .lineLimit(1)
                                    TextEditor(text: Binding(get: { self.mViewModel.Application!.Notes }, set: { self.mViewModel.Application!.Notes  = $0 }))
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
            .onChange(of: Action) { newValue in
                switch(newValue) {
                    case 1:
                        self.mViewModel.saveItem()
                    case 2:
                        self.mViewModel.saveItem()
                    case 3:
                        self.mViewModel.removeApplicationItems(items: self.SelectedItems)
                        self.SelectedItems.removeAll()
                    default: ()
                }
                self.Action = 0
            }
            .onChange(of: self.mViewModel.ActionResult) { newValue in
                if newValue != nil {
                    switch(newValue!) {
                        case OperationResult.Error:
                                self.mToastText = NSLocalizedString("message_save_error", comment: "")
                                self.ShowToast = true
                        case OperationResult.Create:
                                presentationMode.wrappedValue.dismiss()
                        case OperationResult.Update:
                                presentationMode.wrappedValue.dismiss()
                            default: print()
                    }
                    self.ActionResult = newValue
                    self.mViewModel.ActionResult = nil
                }
            }
            
            if self.ShowDatePicker {
                DatetimePicker(showDatePicker: $ShowDatePicker, selectedDate: $SelectedDate)
            }
            
            ToastView(text: self.mToastText, visible: $ShowToast)
        }
    }
}

