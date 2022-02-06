//
//  RegistrationView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 05.02.2022.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var mViewModel: RegistrationViewModel
    @State var Field: String = ""
    @State var SelectedActivateType: Int = 1
    @State var PinCode: String = ""
    @State var ToastMessage: String?
    
    init() {
        self.mViewModel = RegistrationViewModel()
    }
    
    var body: some View {
        ZStack {
           GeometryReader { geo in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        switch self.mViewModel.ActionResult {
                            case 1:
                                VStack {
                                    Text("message_registration_success")
                                        .frame(alignment: .center)
                                        .padding(.bottom, 4)
                                        .foregroundColor(Color.textLight)
                                        .font(.system(size: 18, weight: .bold))
                                        .lineLimit(1)
                                    VStack {
                                        if self.SelectedActivateType == 1 {
                                            CustomText("message_registration_email_success", alignment: .center)
                                        }
                                        else {
                                            CustomText("message_registration_phone_success", alignment: .center)
                                            CustomTextField($PinCode)
                                                .multilineTextAlignment(.center)
                                        }
                                    }
                                    .padding(.bottom, 8)
                                    Button(action: {
                                        if self.SelectedActivateType == 1 {
                                            self.presentationMode.wrappedValue.dismiss()
                                        }
                                        else {
                                            self.mViewModel.activateUser(pinCode: self.PinCode)
                                        }
                                    }, label: {
                                        Text("string_complete")
                                            .frame(maxWidth: .infinity)
                                    })
                                    .frame(maxWidth: .infinity, minHeight: 50)
                                    .background(Color.secondary)
                                    .foregroundColor(Color.textDark)
                                    .cornerRadius(4)
                                }
                            case 2:
                                VStack {
                                    CustomText("message_activate_success", alignment: .center)
                                }
                                .padding(.bottom, 8)
                                Button(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                }, label: {
                                    Text("string_complete")
                                        .frame(maxWidth: .infinity)
                                })
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(Color.secondary)
                                .foregroundColor(Color.textDark)
                                .cornerRadius(4)
                            default:
                                VStack {
                                    VStack {
                                        Text("app_owner")
                                            .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            .foregroundColor(Color.textLight)
                                            .font(.system(size: 22, weight: .bold))
                                            .lineLimit(1)
                                        CustomText("app_name", alignment: .center, bold: true)
                                    }
                                    .padding(.bottom, 12)
                                    VStack {
                                        CustomText("string_user_login", bold: true)
                                        CustomTextField(Binding(get: { self.mViewModel.RegistrationModel.Login }, set: { self.mViewModel.RegistrationModel.Login = $0 }))
                                    }
                                    VStack {
                                        CustomText("string_user_password", bold: true)
                                        SecureField("", text: Binding(get: { self.mViewModel.RegistrationModel.Password }, set: { self.mViewModel.RegistrationModel.Password = $0 }))
                                            .frame(minHeight: 30, maxHeight: 30)
                                            .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                                            .background(Color.inputBackgroud)
                                            .foregroundColor(Color.textDark)
                                            .cornerRadius(4)
                                            .textContentType(.oneTimeCode)
                                    }
                                    VStack {
                                        CustomText("string_user_password_repeat", bold: true)
                                        SecureField("", text: Binding(get: { self.mViewModel.RegistrationModel.RepeatPassword }, set: { self.mViewModel.RegistrationModel.RepeatPassword = $0 }))
                                            .frame(minHeight: 30, maxHeight: 30)
                                            .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                                            .background(Color.inputBackgroud)
                                            .foregroundColor(Color.textDark)
                                            .cornerRadius(4)
                                            .textContentType(.oneTimeCode)
                                    }
                                    VStack {
                                        CustomText("string_activate", bold: true)
                                        Picker("", selection: $SelectedActivateType) {
                                            Text("string_activate_email").tag(1)
                                            Text("string_activate_phone").tag(2)
                                        }
                                        .pickerStyle(SegmentedPickerStyle())
                                        if self.SelectedActivateType == 1 {
                                            CustomTextField(Binding(get: { self.mViewModel.RegistrationModel.Email }, set: { self.mViewModel.RegistrationModel.Email = $0 }))
                                        }
                                        else {
                                            CustomTextField(Binding(get: { self.mViewModel.RegistrationModel.Phone }, set: { self.mViewModel.RegistrationModel.Phone = $0 }))
                                        }
                                    }
                                    .padding(.bottom, 8)
                                    VStack {
                                        Button(action: {
                                            self.mViewModel.createUser()                            }, label: {
                                            Text("string_continue")
                                                .frame(maxWidth: .infinity)
                                        })
                                        .frame(maxWidth: .infinity, minHeight: 50)
                                        .background(Color.secondary)
                                        .foregroundColor(Color.textDark)
                                        .cornerRadius(4)
                                    }
                                }
                        }
                    }
                    .frame(maxWidth: 400, alignment: .center)
                    .frame(minHeight: geo.size.height)
                    .padding(.all, 24)
                }
                .frame(width: geo.size.width)
            }
            ToastView($ToastMessage)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(EdgeInsets(top: 24, leading: 0, bottom: 24, trailing: 0))
        .background(Color.primaryDark)
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(false)
        .navigationBarTitle("string_user_registration", displayMode: .inline)
        .keyboardResponsive()
        .onAppear() {
            self.mViewModel.RegistrationModel = RegistrationModel()
            self.mViewModel.ActionResult = nil
        }
        .onChange(of: self.SelectedActivateType) { newValue in
            self.mViewModel.RegistrationModel.ActivateType = newValue
            self.mViewModel.RegistrationModel.Email = ""
            self.mViewModel.RegistrationModel.Phone = ""
        }
        .onChange(of: self.mViewModel.IsError) { newValue in
            if newValue {
                self.ToastMessage = NSLocalizedString("message_save_error", comment: "")
            }
        }
    }
}

