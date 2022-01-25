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
    @Binding var Refresh: Bool?
    
    init(entityId: Int, refresh: Binding<Bool?>) {
        self.mEntityId = entityId
        self._Refresh = refresh
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
                                NavigationLink(destination: DocumentView(entityId: document.Id, names: [document.DocumentType!.Name, document.Number!], mode: ModeView.View, refresh: $Refresh)) {
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
        .onChange(of: self.Refresh) { newValue in
            if newValue != nil {
                self.mViewModel.Order = nil
            }
        }
    }
}
