//
//  OrderInvoicesView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 22.01.2022.
//

import SwiftUI

struct OrderInvoicesView: View {
    @ObservedObject var mViewModel: OrderViewModel
    var mEntityId: Int
    @State var ActionResult: OperationResult?
    @State var InvoiceId: Int?
    
    init(entityId: Int) {
        self.mEntityId = entityId
        self.mViewModel = OrderViewModel(entityId: entityId, include: "applications,companies,documents,invoices,users")
    }
    
    var body: some View {
        VStack {
            if self.mViewModel.IsLoading == true  {
                LoadingView()
            }
            else if self.mViewModel.IsError {
                ErrorView()
            }
            else if self.mViewModel.Order?.getInvoices().count == 0  {
                EmptyView()
            }
            else {
                List {
                    if self.mViewModel.Order != nil {
                        ForEach(self.mViewModel.Order!.getInvoices()) { invoice in
                            VStack {
                                NavigationLink(destination: InvoiceView(entityId: invoice.Id, names: [invoice.InvoiceType!.Name, invoice.Number!], mode: ModeView.View, result: $ActionResult), tag: invoice.Id, selection:  $InvoiceId)  {
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
            if self.mViewModel.Order == nil {
                self.mViewModel.loadData()
            }
        }
    }
}
