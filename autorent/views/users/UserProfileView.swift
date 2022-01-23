//
//  UserProfileView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 23.01.2022.
//

import SwiftUI

struct UserProfileView: View, Equatable {
    @ObservedObject var mViewModel: UserProfileViewModel
    var mEntityId: Int
    @State var ToastMessage: String?
    
    init(entityId: Int) {
        self.mEntityId = entityId
        self.mViewModel = UserProfileViewModel(entityId: entityId, include: "addresses,roles")
    }
    
    static func == (lhs: UserProfileView, rhs: UserProfileView) -> Bool {
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
                else if self.mViewModel.User != nil {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            HStack {
                                Image("user")
                                    .resizable()
                                    .frame(width: 30, height: 35)
                                    .foregroundColor(Color.textLight)
                                VStack {
                                    CustomText(self.mViewModel.User!.Profile.getUserName(), bold: true)
                                    CustomText(self.mViewModel.User!.Login)
                                }
                            }
                            .padding(.bottom, 4)
                            VStack {
                                CustomText("string_user_information", maxLines: 1, bold: true)
                                CustomText(String(format: "%@ %@", NSLocalizedString("string_user_inn", comment: ""), self.mViewModel.User!.Profile.INN ?? ""))
                                CustomText(String(format: "%@ %@", NSLocalizedString("string_user_snils", comment: ""), self.mViewModel.User!.Profile.SNILS ?? ""))
                            }
                            .padding(.bottom, 4)
                            VStack {
                                CustomText("string_user_passport", maxLines: 1, bold: true)
                                CustomText(String(format: NSLocalizedString("string_user_passportInfo", comment: ""), self.mViewModel.User!.Profile.PassportNumber ?? "", self.mViewModel.User!.Profile.PassportOrg ?? "", Utils.formatDate(format: "dd MMMM yyyy", date: self.mViewModel.User!.Profile.PassportDate)))
                            }
                            .padding(.bottom, 4)
                            VStack {
                                CustomText("string_user_contacts", maxLines: 1, bold: true)
                                CustomText(self.mViewModel.User!.Profile.MobilePhone ?? "", image: "iconmonstr-phone")
                                CustomText(self.mViewModel.User!.Profile.Email ?? "", image: "iconmonstr-email")
                            }
                            .padding(.bottom, 4)
                            HStack {
                                Image("map-marker-alt")
                                    .resizable()
                                    .frame(width: 15, height: 20)
                                    .foregroundColor(Color.textLight)
                                ForEach(self.mViewModel.User!.Profile.Addresses) { address in
                                    VStack {
                                        CustomText(address.AddressType.Name, bold: true)
                                        CustomText(address.getAddressName())
                                    }
                                }
                            }
                            .padding(.bottom, 4)
                            HStack {
                                VStack {
                                    HStack {
                                        Image("address-book")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(Color.textLight)
                                        CustomText("string_companies", alignment: .center, maxLines: 1)
                                    }
                                    .frame(alignment: .center)
                                    .padding(.all, 12)
                                }
                                .frame(maxWidth: .infinity)
                                .background(Color.primaryDark)
                                .cornerRadius(5)
                                VStack {
                                    HStack {
                                        Image("iconmonstr-gear")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(Color.textLight)
                                        CustomText("string_vehicles", alignment: .center, maxLines: 1)
                                    }
                                    .frame(alignment: .center)
                                    .padding(.all, 12)
                                }
                                .frame(maxWidth: .infinity)
                                .background(Color.primaryDark)
                                .cornerRadius(5)
                            }
                        }
                        .padding(.all, 12)
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .background(Color.primary)
            .onAppear {
                if self.mViewModel.User == nil {
                    self.mViewModel.loadData()
                }
            }
            ToastView($ToastMessage)
        }
    }
}
