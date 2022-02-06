//
//  LoginView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 28.01.2022.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var mViewModel: AuthenticationViewModel
    @State var Authenticated: Bool = false
    @State var Login: String = ""//info@sedcom.ru"
    @State var Password: String = ""//password"
    @State var ToastMessage: String?
    
    init () {
        self.mViewModel = AuthenticationViewModel()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if self.Authenticated {
                    MainView()
                }
                else {
                    VStack {
                        GeometryReader { geo in
                            ScrollView(.vertical, showsIndicators: false) {
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
                                        CustomTextField($Login)
                                    }
                                    VStack {
                                        CustomText("string_user_password", bold: true)
                                        SecureField("", text: $Password)
                                            .frame(minHeight: 30, maxHeight: 30)
                                            .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                                            .background(Color.inputBackgroud)
                                            .foregroundColor(Color.textDark)
                                            .cornerRadius(4)
                                    }
                                    .padding(.bottom, 8)
                                    VStack {
                                        Button(action: {
                                            self.mViewModel.authenticateUser(login: self.Login, password: self.Password)
                                        }, label: {
                                            Text("string_enter")
                                                .frame(maxWidth: .infinity)
                                        })
                                        .frame(maxWidth: .infinity, minHeight: 50)
                                        .background(Color.secondary)
                                        .foregroundColor(Color.textDark)
                                        .cornerRadius(4)
                                    }
                                    .padding(.bottom, 4)
                                    HStack {
                                        NavigationLink(destination: RegistrationView()) {
                                            CustomText("string_user_registration")
                                        }
                                    }
                                }
                                .frame(maxWidth: 400, alignment: .center)
                                .frame(minHeight: geo.size.height)
                                .padding(.all, 24)
                            }
                            .navigationBarHidden(!self.Authenticated)
                            .frame(width: geo.size.width)
                            ToastView($ToastMessage)
                        }
                    }
                    .padding(EdgeInsets(top: 24, leading: 0, bottom: 24, trailing: 0))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.primaryDark)
            .edgesIgnoringSafeArea(.all)
            .onChange(of: self.mViewModel.ActionResult) { newValue in
                if newValue != nil {
                    self.Authenticated = newValue!
                    if newValue! == false {
                        self.ToastMessage = NSLocalizedString("message_authentication_error", comment: "")
                        self.Password = ""
                    }
                    self.mViewModel.ActionResult = nil
                }
            }
        }
        .environment(\.horizontalSizeClass, .compact)
        .environment(\.verticalSizeClass, .compact)
    }
}
