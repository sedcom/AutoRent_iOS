//
//  DocumentInvoicesView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 22.01.2022.
//

import SwiftUI

struct DocumentInvoicesView: View {
    @ObservedObject var mViewModel: DocumentViewModel
    var mEntityId: Int
    @Binding var Refresh: Bool?
    
    init(entityId: Int, refresh: Binding<Bool?>) {
        self.mEntityId = entityId
        self._Refresh = refresh
        self.mViewModel = DocumentViewModel(entityId: entityId, include: "orders,invoices")
    }
    
    var body: some View {
        VStack {
            if self.mViewModel.IsLoading == true  {
                LoadingView()
            }
            else if self.mViewModel.IsError {
                ErrorView()
            }
            else if self.mViewModel.Document?.Invoices.count == 0  {
                EmptyView()
            }
            else {
                List {
                    if self.mViewModel.Document != nil {
                        ForEach(self.mViewModel.Document!.Invoices) { invoice in
                            VStack {
                                NavigationLink(destination: InvoiceView(entityId: invoice.Id, mode: ModeView.View, refresh: $Refresh))  {
                                    InvoicesRowView(invoice)
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
            if self.mViewModel.Document == nil {
                self.mViewModel.loadData()
            }
        }
        .onChange(of: self.Refresh) { newValue in
            if newValue != nil {
                self.mViewModel.Document = nil
            }
        }
    }
}
