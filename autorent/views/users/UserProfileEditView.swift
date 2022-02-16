//
//  UserProfileEditView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 23.01.2022.
//

import SwiftUI

struct UserProfileEditView: View, Equatable {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var mViewModel: UserProfileViewModel
    var mEntityId: Int
    @State var ShowDatePicker: Bool = false
    @State var SelectedDate: Date = Date()
    @State var SelectedPage: Int = 1
    @State var Action: Int?
    @Binding var ActionResult: OperationResult?
    @State var ToastMessage: String?
    
    init(result: Binding<OperationResult?>) {
        self.mEntityId = AuthenticationService.getInstance().getCurrentUser()!.Id
        self._ActionResult = result
        self.mViewModel = UserProfileViewModel(entityId: self.mEntityId, include: "addresses,roles")
    }

    static func == (lhs: UserProfileEditView, rhs: UserProfileEditView) -> Bool {
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
                    VStack {
                        GeometryReader { geo in
                            HStack {
                                VStack {
                                    CustomText("string_user_main", alignment: .center, bold: true)
                                        .padding(EdgeInsets(top: 12, leading: 4, bottom: 4, trailing: 4))
                                        .onTapGesture {
                                            self.SelectedPage = 1
                                        }
                                    Divider()
                                        .frame(height: 3)
                                        .background(self.SelectedPage == 1 ? Color.secondary: Color.primaryDark)
                                }
                                VStack {
                                    CustomText("string_user_addresses", alignment: .center, bold: true)
                                        .padding(EdgeInsets(top: 12, leading: 4, bottom: 4, trailing: 4))
                                        .onTapGesture {
                                            self.SelectedPage = 2
                                        }
                                    Divider()
                                        .frame(height: 3)
                                        .background(self.SelectedPage == 2 ? Color.secondary: Color.primaryDark)
                                }
                            }
                            .background(Color.primaryDark)
                            TabView(selection: $SelectedPage) {
                                ZStack {
                                    ScrollView(.vertical, showsIndicators: false) {
                                        VStack {
                                            VStack {
                                                CustomText("string_user_firstName")
                                                CustomTextField(Binding(get: { self.mViewModel.User!.Profile.FirstName }, set: { self.mViewModel.User!.Profile.FirstName  = $0 }))
                                            }
                                            VStack {
                                                CustomText("string_user_middleName")
                                                CustomTextField(Binding(get: { self.mViewModel.User!.Profile.MiddleName ?? "" }, set: { self.mViewModel.User!.Profile.MiddleName  = $0 }))
                                            }
                                            VStack {
                                                CustomText("string_user_lastName")
                                                CustomTextField(Binding(get: { self.mViewModel.User!.Profile.LastName }, set: { self.mViewModel.User!.Profile.LastName  = $0 }))
                                            }
                                            VStack {
                                                CustomText("string_user_inn")
                                                CustomTextField(Binding(get: { self.mViewModel.User!.Profile.INN ?? "" }, set: { self.mViewModel.User!.Profile.INN  = $0 }))
                                            }
                                            VStack {
                                                CustomText("string_user_snils")
                                                CustomTextField(Binding(get: { self.mViewModel.User!.Profile.SNILS ?? "" }, set: { self.mViewModel.User!.Profile.SNILS  = $0 }))
                                            }
                                            VStack {
                                                CustomText("string_user_passportNumber")
                                                CustomTextField(Binding(get: { self.mViewModel.User!.Profile.PassportNumber ?? "" }, set: { self.mViewModel.User!.Profile.PassportNumber  = $0 }))
                                            }
                                            VStack {
                                                CustomText("string_user_passportDate")
                                                CustomTextField(Binding(get: { self.mViewModel.User!.Profile.PassportDate != nil ? Utils.formatDate(format: "dd MMMM yyyy", date: self.mViewModel.User!.Profile.PassportDate!)  : "" }, set: { _ in }), disabled: true)
                                                    .onChange(of:  $SelectedDate.wrappedValue, perform: { value in
                                                        self.mViewModel.User!.Profile.PassportDate = value
                                                        self.mViewModel.objectWillChange.send()
                                                    })
                                                    .onTapGesture {
                                                        self.ShowDatePicker.toggle()
                                                    }
                                            }
                                            VStack {
                                                CustomText("string_user_passportOrg")
                                                CustomTextField(Binding(get: { self.mViewModel.User!.Profile.PassportOrg ?? "" }, set: { self.mViewModel.User!.Profile.PassportOrg = $0 }))
                                            }
                                            VStack {
                                                CustomText("string_user_email")
                                                CustomTextField(Binding(get: { self.mViewModel.User!.Profile.Email ?? "" }, set: { self.mViewModel.User!.Profile.Email  = $0 }))
                                            }
                                            VStack {
                                                CustomText("string_user_phone")
                                                CustomTextField(Binding(get: { self.mViewModel.User!.Profile.MobilePhone ?? "" }, set: { self.mViewModel.User!.Profile.MobilePhone  = $0 }))
                                            }
                                        }
                                        .padding(.all, 12)
                                    }
                                    ZStack {
                                        ZStack {
                                            Circle().fill(Color.secondary)
                                            Image("save")
                                                .renderingMode(.template)
                                                .resizable()
                                                .frame(width: 25, height: 30)
                                                .foregroundColor(Color(UIColor.darkGray))
                                        }
                                        .frame(width: 60, height: 60)
                                        .onTapGesture {
                                            self.Action = 1
                                        }
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                                    .offset(x: geo.size.width - 70, y: -5)
                                }
                                .tag(1)
                                ZStack {
                                    List {
                                        if self.mViewModel.User != nil {
                                            ForEach(self.mViewModel.User!.Profile.Addresses) { address in
                                                VStack {
                                                    HStack {
                                                        Image("map-marker-alt")
                                                            .renderingMode(.template)
                                                            .foregroundColor(Color.textLight)
                                                        VStack {
                                                            CustomText(address.AddressType.Name, bold: true)
                                                            CustomText(address.getAddressName())
                                                        }
                                                    }
                                                    .padding(.all, 8)
                                                }
                                                .background(Color.primaryDark)
                                                .cornerRadius(5)
                                                .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
                                            }
                                            .listRowBackground(Color.primary)
                                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                        }
                                    }
                                    .listStyle(PlainListStyle())
                                    .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                                    ZStack {
                                        ZStack {
                                            Circle().fill(Color.secondary)
                                            Image("plus")
                                                .renderingMode(.template)
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .foregroundColor(Color(UIColor.darkGray))
                                        }
                                        .frame(width: 60, height: 60)
                                        .onTapGesture {
                                            self.Action = 2
                                        }
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                                    .offset(x: geo.size.width - 70, y: -5)
                                }
                                .tag(2)
                            }
                            .padding(.top, 50)
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        }
                    }
                }
            }
            .background(Color.primary.edgesIgnoringSafeArea(.all))
            .navigationBarHidden(false)
            .navigationBarTitle(NSLocalizedString("title_userprofile", comment: ""), displayMode: .inline)
            .onAppear {
                if self.mViewModel.User == nil {
                    self.mViewModel.loadData()
                }
            }
            .onChange(of: self.Action) { newValue in
                switch(newValue) {
                    case 1:
                        self.mViewModel.saveItem()
                    default: ()
                }
                self.Action = nil
            }
            .onChange(of: self.mViewModel.ActionResult) { newValue in
                if newValue != nil {
                    switch(newValue!) {
                        case OperationResult.Error:
                            self.ToastMessage = NSLocalizedString("message_save_error", comment: "")
                        case OperationResult.Update: ()
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
