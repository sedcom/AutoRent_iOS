//
//  ApplicationMainEditView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 05.01.2022.
//

import SwiftUI

struct ApplicationMainEditView: View {
    @ObservedObject var mViewModel: ApplicationViewModel
    @State var showDatePicker: Bool = false
    @State var datePicker: Date = Date()
    var mCurrentMode: ModeView
    var mEntityId: Int
    
    init(entityId: Int, mode: ModeView) {
        self.mEntityId = entityId
        self.mCurrentMode = mode
        self.mViewModel = ApplicationViewModel(entityId: entityId, include: "companies,items,history,userprofiles")
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
                                    let index = self.mViewModel.Application!.Items.firstIndex(of: item)! + 1
                                    ApplicationItemEditView(applicationItem: item, index: index, showDatePicker: $showDatePicker, datePicker: $datePicker)
                                }
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
            if self.showDatePicker {
                DatetimePicker(showDatePicker: $showDatePicker, datePicker: $datePicker)
            }
        }
    }
}

