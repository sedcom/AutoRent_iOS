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
    @State var mEditMode: Bool?
    @State var ActionResult: OperationResult?
    @State var ToastMessage: String?
    
    init() {
        self.mEntityId = AuthenticationService.getInstance().getCurrentUser()!.Id
        self.mViewModel = UserProfileViewModel(entityId: self.mEntityId, include: "addresses,roles")
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
                    ZStack {
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
                                            NavigationLink(destination: CompaniesView()) {
                                                Image("address-book")
                                                    .resizable()
                                                    .frame(width: 30, height: 30)
                                                    .foregroundColor(Color.textLight)
                                                CustomText("string_companies", alignment: .center, maxLines: 1)
                                            }
                                        }
                                        .frame(alignment: .center)
                                        .padding(.all, 12)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .background(Color.primaryDark)
                                    .cornerRadius(5)
                                    VStack {
                                        HStack {
                                            NavigationLink(destination: VehiclesView()) {
                                                Image("iconmonstr-gear")
                                                    .resizable()
                                                    .frame(width: 30, height: 30)
                                                    .foregroundColor(Color.textLight)
                                                CustomText("string_vehicles", alignment: .center, maxLines: 1)
                                            }
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
                        ZStack {
                            ZStack {
                                Circle().fill(Color.secondary)
                                Image("pencil-alt")
                                    .renderingMode(.template)
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color(UIColor.darkGray))
                            }
                            .frame(width: 60, height: 60)
                            .onTapGesture {
                                self.mEditMode = true
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                        .offset(x: -10, y: -10)
                        ZStack {
                            ToastView($ToastMessage)
                        }
                    }
                }
            }
            .background(Color.primary)
            .onAppear {
                if self.mViewModel.User == nil {
                    self.mViewModel.loadData()
                }
            }
            .onChange(of: self.ActionResult) { newValue in
                if newValue != nil {
                    switch(newValue!) {
                        case OperationResult.Update:
                            self.ToastMessage = NSLocalizedString("message_save_success", comment: "")
                            self.mViewModel.loadData()
                        default: ()
                    }
                    self.ActionResult = nil
                }
            }
            
            NavigationLink(destination: UserProfileEditView(result: $ActionResult), tag: true, selection: $mEditMode)  { }
        }
    }
}
