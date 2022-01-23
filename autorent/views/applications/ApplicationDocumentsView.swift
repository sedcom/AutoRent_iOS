//
//  ApplicationDocumentsView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 22.01.2022.
//

import SwiftUI

struct ApplicationDocumentsView: View {
    @ObservedObject var mViewModel: ApplicationViewModel
    var mEntityId: Int
    @State var ActionResult: OperationResult?
    
    init(entityId: Int) {
        self.mEntityId = entityId
        self.mViewModel = ApplicationViewModel(entityId: entityId, include: "companies,documents,userprofiles")
    }
    
    var body: some View {
        VStack {
            if self.mViewModel.IsLoading == true  {
                LoadingView()
            }
            else if self.mViewModel.IsError {
                ErrorView()
            }
            else if self.mViewModel.Application?.getDocuments().count == 0  {
                EmptyView()
            }
            else {
                List {
                    if self.mViewModel.Application != nil {
                        ForEach(self.mViewModel.Application!.getDocuments()) { document in
                            VStack {
                                NavigationLink(destination: DocumentView(entityId: document.Id, mode: ModeView.View, result: $ActionResult))  {
                                    DocumentsRowView(document)
                                }
                            }
                        }
                        .listRowBackground(Color.primary)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: -20))
                    }
                }
                .listStyle(PlainListStyle())
                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
            }
        }
        .background(Color.primary)
        .onAppear {
            self.mViewModel.loadData()
        }
    }
}
