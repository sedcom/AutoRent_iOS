//
//  ApplicationsView.swift
//  autorent
//
//  Created by Semyon Kravchenko on 27.11.2021.
//

import SwiftUI

struct ApplicationsView: View {
    @ObservedObject var mViewModel: ApplicationsViewModel
    @State private var mSelectedFilter = 0
    @State private var mId = 0

    init() {
        self.mViewModel = ApplicationsViewModel(maxItems: 10, skipCount: 0)
    }

    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading){
                    Text("Заявки на услуги").padding()
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Button(action: {}) {
                            Text("Все").foregroundColor(Color(UIColor(hex: "495057"))).padding(.all, 8)
                        }.background(Color(UIColor(hex: "E7E7E7"))).cornerRadius(10.0)
                        Button(action: {}) {
                            Text("Черновики").foregroundColor(Color(UIColor(hex: "495057"))).padding(.all, 8)
                        }.background(Color(UIColor(hex: "E7E7E7"))).cornerRadius(10.0)
                        Button(action: {}) {
                            Text("В процессе").foregroundColor(Color(UIColor(hex: "495057"))).padding(.all, 8)
                        }.background(Color(UIColor(hex: "E7E7E7"))).cornerRadius(10.0)
                        Button(action: {}) {
                            Text("Выполнены").foregroundColor(Color(UIColor(hex: "495057"))).padding(.all, 8)
                        }.background(Color(UIColor(hex: "E7E7E7"))).cornerRadius(10.0)
                        Button(action: {}) {
                            Text("Завершены").foregroundColor(Color(UIColor(hex: "495057"))).padding(.all, 8)
                        }.background(Color(UIColor(hex: "E7E7E7"))).cornerRadius(10.0)
                    }
                }.padding(.horizontal, 8)
                List(self.mViewModel.Applications) { application in
                    VStack {
                        ApplicationsRowView(application)
                    }.onAppear {
                        if application == self.mViewModel.Applications.last {
                            self.mViewModel.mSkipCount = self.mViewModel.Applications.count
                            self.mViewModel.loadData()
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }.onAppear {
            self.mViewModel.clearData()
            self.mViewModel.loadData()
        }
    }
}
