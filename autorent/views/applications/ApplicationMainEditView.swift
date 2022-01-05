//
//  ApplicationMainEditView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 05.01.2022.
//

import SwiftUI

struct ApplicationMainEditView: View {
    @ObservedObject var mViewModel: ApplicationViewModel
    @State var mNotes: String
    var mCurrentMode: ModeView
    var mEntityId: Int
    
    init(entityId: Int, mode: ModeView) {
        self.mEntityId = entityId
        self.mCurrentMode = mode
        self.mNotes = ""
        self.mViewModel = ApplicationViewModel(entityId: entityId, include: "companies,items,history,userprofiles")
    }
    
    var body: some View {
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
                                Text(self.mViewModel.Application!.User.Profile.getUserName())
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
                            HStack {
                                TextField("", text: $mNotes)
                                    .frame(minHeight: 30, maxHeight: 30)
                                    .background(Color.inputBackgroud)
                                    .cornerRadius(4)
                            }
                            .padding(.bottom, 4)
                            ForEach(self.mViewModel.Application!.Items) { item in
                                let index = self.mViewModel.Application!.Items.firstIndex(of: item)! + 1
                                ApplicationItemView(applicationItem: item, index: index)
                            }
                            Text("Описание")
                                .foregroundColor(Color.textLight)
                                .font(Font.headline.weight(.bold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .lineLimit(1)
                            TextEditor(text: $mNotes)
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
            if self.mCurrentMode == ModeView.Create {
                self.mViewModel.createItem()
            }
            else {
                self.mViewModel.loadData()
            }
        }
    }
}

