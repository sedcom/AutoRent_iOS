//
//  ApplicationMainEditView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 05.01.2022.
//

import SwiftUI

struct ApplicationMainEditView: View, Equatable {
    @ObservedObject public var mViewModel: ApplicationViewModel
    var mCurrentMode: ModeView
    var mEntityId: Int
    @State var showDatePicker: Bool = false
    @State var selectedDate: Date = Date()
    @Binding var selectedItems: [UUID]
    @Binding var action: Int?
    
    init(entityId: Int, mode: ModeView, action: Binding<Int?>, selectedItems: Binding<[UUID]>) {
        self.mEntityId = entityId
        self.mCurrentMode = mode
        self._action = action
        self._selectedItems = selectedItems
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
                                        ApplicationItemEditView(viewModel: self.mViewModel, mode: self.mCurrentMode, index: index, showDatePicker: $showDatePicker, selectedDate: $selectedDate, selectedItems: $selectedItems)
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
            .onChange(of: action) { newValue in
                switch(newValue) {
                    case 1:
                        self.mViewModel.saveItem()
                    case 2:
                        //self.mViewModel.saveItem()
                        let _ = print("Event 2")
                    case 3:
                        self.mViewModel.removeApplicationItems(items: self.selectedItems)                        
                        self.selectedItems.removeAll()
                    default:
                        self.action = 0
                }
                self.action = 0
            }
            .onChange(of: self.mViewModel.saveResult) { newValue in
                switch(newValue) {
                    case 1:
                       print("Event \(self.mViewModel.saveResult)")
                    case 2:
                        print("Event \(self.mViewModel.saveResult)")
                        self.action = 5
                    case 3:
                        print("Event \(self.mViewModel.saveResult)")
                    default:
                        print("Event \(self.mViewModel.saveResult)")
                }
            }
            if self.mViewModel.Application != nil {
                //NavigationLink(destination: ApplicationView(entityId: self.mViewModel.Application!.Id, mode: ModeView.View), tag: 2, selection: Binding(get: { self.mViewModel.saveResult}, set: { _ in }))  { }
            }
           
            
            if self.showDatePicker {
                DatetimePicker(showDatePicker: $showDatePicker, selectedDate: $selectedDate)
            }
            if self.mViewModel.saveResult == 2 {
                Text("Result: 2")
                    .foregroundColor(Color.red)
            }
            if self.mViewModel.saveResult == 3 {
                Text("Result: 3")
                    .foregroundColor(Color.red)
            }
        }
    }
}

