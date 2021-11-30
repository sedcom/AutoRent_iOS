//
//  ApplicationsView.swift
//  autorent
//
//  Created by Semyon Kravchenko on 27.11.2021.
//

import SwiftUI

struct ApplicationsView: View {
    @ObservedObject var mViewModel: ApplicationsViewModel
    
    init() {
        self.mViewModel = ApplicationsViewModel(maxItems: 10, skipCount: 0)
    }

    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack {
                        Text("Все").padding()
                        Text("Черновики").padding()
                        Text("В процессе").padding()
                        Text("Выполнены").padding()
                        Text("Завершены").padding()
                    }
                }
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
        }.onAppear { self.mViewModel.loadData() }
    }
}
