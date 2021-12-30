//
//  ApplicationMainView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 26.12.2021.
//

import SwiftUI

struct ApplicationMainView: View {
    @ObservedObject var mViewModel: ApplicationViewModel
    var mEntityId: Int
    
    init(entityId: Int) {
        self.mEntityId = entityId
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
                            VStack {
                                VStack {
                                    HStack {
                                        HStack {
                                            Image("calendar-alt")
                                                .renderingMode(.template)
                                                .resizable()
                                                .foregroundColor(Color.textLight)
                                                .frame(width: 30, height: 35)
                                            VStack {
                                                Text(Utils.formatDate(format: "dd MMMM yyyy", date: item.StartDate))
                                                Text(Utils.formatDate(format: "HH:mm ZZZZZ", date: item.StartDate))
                                            }
                                        }
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .background(Color.primary)
                                        .padding(.all, 8)
                                        HStack {
                                            Image("calendar-alt")
                                                .renderingMode(.template)
                                                .resizable()
                                                .foregroundColor(Color.textLight)
                                                .frame(width: 30, height: 35)
                                            VStack {
                                                Text(Utils.formatDate(format: "dd MMMM yyyy", date: item.FinishDate))
                                                Text(Utils.formatDate(format: "HH:mm ZZZZZ", date: item.StartDate))
                                            }
                                        }
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .background(Color.primary)
                                        .padding(.all, 8)
                                    }
                                    
                                }
                                .padding(.all, 8)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color.primaryDark)
                            .cornerRadius(5)
                            
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
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.primary)
        .navigationBarHidden(false)
        .onAppear {
            self.mViewModel.loadData()
        }
    }
}
