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
    
    init(entityId: Int, mode: ModeView) {
        self.mEntityId = entityId
        self.mCurrentMode = mode
        self.mViewModel = ApplicationViewModel(entityId: entityId, include: "companies,items,history,userprofiles")
    }
    
    static func == (lhs: ApplicationMainView, rhs: ApplicationMainView) -> Bool {
        return true
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
                                Image("map-marker-alt")
                                    .renderingMode(.template)
                                    .foregroundColor(Color.textLight)
                                Text(self.mViewModel.Application!.Address.getAddressName())
                                    .foregroundColor(Color.textLight)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(.bottom, 4)
                            ForEach(self.mViewModel.Application!.Items) { item in
                                let index = self.mViewModel.Application!.Items.firstIndex(of: item)!
                                ApplicationItemView(applicationItem: item, index: index)
                            }
                            Text("Описание")
                                .foregroundColor(Color.textLight)
                                .font(Font.headline.weight(.bold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .lineLimit(1)
                            Text(self.mViewModel.Application!.Notes)
                                .foregroundColor(Color.textLight)
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(maxWidth: .infinity, alignment: .leading)
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
    }
}
