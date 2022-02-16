//
//  CompanyDocumentsView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 16.02.2022.
//

import SwiftUI

struct CompanyDocumentsView: View {
    @ObservedObject var mViewModel: CompanyViewModel
    var mEntityId: Int
    @State var ActionResult: OperationResult?
    @Binding var Refresh: Bool?
    
    init(entityId: Int, refresh: Binding<Bool?>) {
        self.mEntityId = entityId
        self._Refresh = refresh
        self.mViewModel = CompanyViewModel(entityId: entityId, include: "documents")
    }
    
    var body: some View {
        VStack {
            if self.mViewModel.IsLoading == true  {
                LoadingView()
            }
            else if self.mViewModel.IsError {
                ErrorView()
            }
            else if 0 == 0  {
                EmptyView()
            }
            else {
                List {
                    if self.mViewModel.Company != nil {
                        
                    }
                }
                .listStyle(PlainListStyle())
                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
            }
        }
        .background(Color.primary)
        .onAppear {
            if self.mViewModel.Company == nil {
                self.mViewModel.loadData()
            }
        }
        .onChange(of: self.Refresh) { newValue in
            if newValue != nil {
                self.mViewModel.Company = nil
            }
        }
    }
}
