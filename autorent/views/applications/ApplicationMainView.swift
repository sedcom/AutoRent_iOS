//
//  ApplicationMainView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 26.12.2021.
//

import SwiftUI

struct ApplicationMainView: View {
    @ObservedObject var mViewModel: ApplicationViewModel
    var mEntityId: Int
    
    init(entityId: Int) {
        self.mEntityId = entityId
        self.mViewModel = ApplicationViewModel(entityId: entityId, include: "companies,items,history,userprofiles")
    }
    
    var body: some View {
        VStack {
            Text(self.mViewModel.Application?.Notes ?? "")
        }
        .background(Color.primary)
        //.navigationBarHidden(true)
        .onAppear {
            self.mViewModel.loadData()
        }
    }
}
