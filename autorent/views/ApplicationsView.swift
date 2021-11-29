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
                        Text("All").padding()
                        Text("Draft").padding()
                        Text("Process").padding()
                        Text("Complete").padding()
                    }
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
        }
    }
}
