//
//  RestorePasswordView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 06.02.2022.
//

import SwiftUI

struct RestorePasswordView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var mViewModel: AuthenticationViewModel
    @State var Login: String = ""
    @State var ToastMessage: String?
    
    init() {
        self.mViewModel = AuthenticationViewModel()
    }
    
    var body: some View {
        ZStack {
           GeometryReader { geo in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        if self.mViewModel.ActionResult ?? false == true {
                            VStack {
                                CustomText("message_restorepassword_success", alignment: .center)
                                    .padding(.bottom, 4)
                            }
                        }
                        else {
                            VStack {
                                VStack {
                                    CustomText("app_owner", alignment: .center, maxLines: 1, bold: true, size: 22)
                                    CustomText("app_name", alignment: .center, bold: true)
                                }
                                .padding(.bottom, 12)
                                VStack {
                                    CustomText("string_user_login", bold: true)
                                    CustomTextField($Login)
                                }
                                .padding(.bottom, 8)
                                VStack {
                                    Button(action: {
                                        self.mViewModel.restorePassword(login: self.Login)
                                    }, label: {
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
        .navigationBarTitle("string_user_restorepassword", displayMode: .inline)
        .keyboardResponsive()
        .onAppear() {
            self.mViewModel.ActionResult = nil
        }
        .onChange(of: self.mViewModel.IsError) { newValue in
            if newValue {
                self.ToastMessage = NSLocalizedString("message_save_error", comment: "")
            }
        }
    }
}

