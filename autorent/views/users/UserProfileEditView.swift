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
    @Binding var UserProfileMode: Int?
    @State var ToastMessage: String?
    
    init(entityId: Int, mode: Binding<Int?>) {
        self.mEntityId = entityId
        self._UserProfileMode = mode
        self.mViewModel = UserProfileViewModel(entityId: entityId, include: "addresses,roles")
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
                    ZStack {
                        GeometryReader { geo in
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
                                    self.UserProfileMode = nil
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                            .offset(x: geo.size.width - 65, y: -5)
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
            
            if self.ShowDatePicker {
                DatetimePicker(showDatePicker: $ShowDatePicker, selectedDate: $SelectedDate)
            }
            ToastView($ToastMessage)
        }
    }
}
