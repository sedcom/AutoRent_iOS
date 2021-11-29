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
                        Text("Завершены").padding()                    }
                }
                List(mViewModel.Applications) { application in
                    VStack {
                        NavigationLink(destination: ApplicationView(entityId: application.Id)) {
                            HStack  {
                                Text(String(application.Id)).padding()
                                Text(application.Notes)
                            }
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }.onAppear { self.mViewModel.loadData() }
    }
}
