//
//  RegistrationView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 05.02.2022.
//

import SwiftUI

struct RegistrationView: View {
    @ObservedObject var mViewModel: RegistrationViewModel
    @State var Field: String = ""
    @State var SelectedActivateType: Int = 1
    
    init() {
        self.mViewModel = RegistrationViewModel()
    }
    
    var body: some View {
        VStack {
           GeometryReader { geo in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        if self.mViewModel.Result {
                            Text("message_registration_success")
                                .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .padding(.bottom, 4)
                                .foregroundColor(Color.textLight)
                                .font(.system(size: 18, weight: .bold))
                                .lineLimit(1)
                            if self.mViewModel.RegistrationModel.ActivateType == 1 {
                                CustomText("message_registration_email_success", alignment: .center)
                            }
                            else {
                                CustomText("message_registration_phone_success", alignment: .center)
                            }
                        }
                        else {
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
                            }
                            VStack {
                                CustomText("string_user_password_repeat", bold: true)
                                SecureField("", text: Binding(get: { self.mViewModel.RegistrationModel.RepeatPassword }, set: { self.mViewModel.RegistrationModel.RepeatPassword = $0 }))
                                    .frame(minHeight: 30, maxHeight: 30)
                                    .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                                    .background(Color.inputBackgroud)
                                    .foregroundColor(Color.textDark)
                                    .cornerRadius(4)
                            }
                            VStack {
                                CustomText("string_activate", bold: true)
                                Picker("", selection: Binding(get: { self.mViewModel.RegistrationModel.ActivateType }, set: { self.mViewModel.RegistrationModel.ActivateType = $0 })) {
                                    Text("string_activate_email").tag(1)
                                    Text("string_activate_phone").tag(2)
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                CustomTextField($Field)
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
                    .frame(maxWidth: 400, alignment: .center)
                    .frame(minHeight: geo.size.height)
                    .padding(.all, 24)
                }
                .frame(width: geo.size.width)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(EdgeInsets(top: 24, leading: 0, bottom: 24, trailing: 0))
        .background(Color.primaryDark)
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(false)
        .navigationBarTitle("string_user_registration", displayMode: .inline)
        .keyboardResponsive()
        .onAppear() {
            
        }
        /*onChange(of: self.mViewModel.Result) { newValue in
            if newValue != nil {
                
            }
            self.mViewModel.Result = nil
        }*/
    }
}

