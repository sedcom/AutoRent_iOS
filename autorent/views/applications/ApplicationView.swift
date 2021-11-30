//
//  ApplicationView.swift
//  autorent
//
//  Created by Semyon Kravchenko on 29.11.2021.
//

import SwiftUI

struct ApplicationView: View {
    @ObservedObject var mViewModel: ApplicationViewModel
    var mEntityId: Int
    
    init(entityId: Int) {
        self.mEntityId = entityId
        self.mViewModel = ApplicationViewModel(entityId: entityId, include: "")
    }
    
    var body: some View {
        VStack {
            Text(self.mViewModel.Application?.Notes ?? "")
        }.onAppear { self.mViewModel.loadData() }
    }
}
