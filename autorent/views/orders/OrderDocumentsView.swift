//
//  OrderDocumentsView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 21.01.2022.
//

import SwiftUI

struct OrderDocumentsView: View {
    @ObservedObject var mViewModel: OrderViewModel
    var mEntityId: Int
    @State var ActionResult: OperationResult?
    @State var DocumentId: Int?
    
    init(entityId: Int) {
        self.mEntityId = entityId
        self.mViewModel = OrderViewModel(entityId: entityId, include: "applications,companies,documents")
    }
    
    var body: some View {
        VStack {
            if self.mViewModel.IsLoading == true  {
                LoadingView()
            }
            else if self.mViewModel.IsError {
                ErrorView()
            }
            else if self.mViewModel.Order?.Documents.count == 0  {
                EmptyView()
            }
            else {
                List {
                    if self.mViewModel.Order != nil {
                        ForEach(self.mViewModel.Order!.Documents) { document in
                            VStack {
                                NavigationLink(destination: DocumentView(entityId: document.Id, mode: ModeView.View, result: $ActionResult), tag: document.Id, selection:  $DocumentId)  {
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
            if self.mViewModel.Order == nil {
                self.mViewModel.loadData()
            }
        }
    }
}
