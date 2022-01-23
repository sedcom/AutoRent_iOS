//
//  ApplicationInvoicesView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 23.01.2022.
//

import SwiftUI

struct ApplicationInvoicesView: View {
    @ObservedObject var mViewModel: ApplicationViewModel
    var mEntityId: Int
    @State var ActionResult: OperationResult?
    
    init(entityId: Int) {
        self.mEntityId = entityId
        self.mViewModel = ApplicationViewModel(entityId: entityId, include: "companies,documents,invoices,orders, userprofiles")
    }
    
    var body: some View {
        VStack {
            if self.mViewModel.IsLoading == true  {
                LoadingView()
            }
            else if self.mViewModel.IsError {
                ErrorView()
            }
            else if self.mViewModel.Application?.getInvoices().count == 0  {
                EmptyView()
            }
            else {
                List {
                    if self.mViewModel.Application != nil {
                        ForEach(self.mViewModel.Application!.getInvoices()) { invoice in
                            VStack {
                                NavigationLink(destination: InvoiceView(entityId: invoice.Id, mode: ModeView.View, result: $ActionResult))  {
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
            self.mViewModel.loadData()
        }
    }
}


