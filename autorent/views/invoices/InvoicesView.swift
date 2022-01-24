//
//  InvoicesView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 22.01.2022.
//

import SwiftUI

struct InvoicesView: View, Equatable  {
    @ObservedObject var mViewModel: InvoicesViewModel
    @State var mCurrentFilter: Int
    @State var ActionResult: OperationResult?
    @State var ToastMessage: String?
     
    init() {
        self.mCurrentFilter = 1
        self.mViewModel = InvoicesViewModel(userId: 1, maxItems: 10, skipCount: 0, orderBy: "Id desc", include: "documents,items,history", filter: "")
    }

    static func == (lhs: InvoicesView, rhs: InvoicesView) -> Bool {
        return true
    }
    
    var body: some View {
        VStack {
            if self.mViewModel.IsLoading == true && self.mViewModel.mSkipCount == 0 {
                LoadingView()
            }
            else if self.mViewModel.IsError {
                ErrorView()
            }
            else {
                VStack (spacing: 0) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack () {
                            Button("status_all", action: { self.setFilter(filterIndex: 1, filter: "") })
                                .buttonStyle(FilterButtonStyle(selected: self.mCurrentFilter == 1))
                            Button("status_invoice_onpayment", action: { self.setFilter(filterIndex: 2, filter: "statusId==2") })
                                .buttonStyle(FilterButtonStyle(selected: self.mCurrentFilter == 2))
                            Button("status_invoice_paid", action: { self.setFilter(filterIndex: 3, filter: "statusId==3") })
                                .buttonStyle(FilterButtonStyle(selected: self.mCurrentFilter == 3))
                            Button("status_invoice_canceled", action: { self.setFilter(filterIndex: 4, filter: "statusId==4") })
                                .buttonStyle(FilterButtonStyle(selected: self.mCurrentFilter == 4))
                        }
                        .padding(.all, 8)
                    }
                    .background(Color.primaryDark)
                    if self.mViewModel.Data.Elements.count == 0 {
                        EmptyView()
                    }
                    else {
                        ZStack {
                            GeometryReader { geo in
                                List {
                                    ForEach(self.mViewModel.Data.Elements) { invoice in
                                        VStack {
                                            if invoice.Id == 0 {
                                                LoadingRowView()
                                            }
                                            else {
                                                NavigationLink(destination: InvoiceView(entityId: invoice.Id, names: [invoice.InvoiceType!.Name, invoice.Number!], mode: ModeView.View, result: $ActionResult))  {
                                                    InvoicesRowView(invoice)
                                                }
                                            }
                                        }
                                        .listRowBackground(Color.primary)
                                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: -20))
                                        .onAppear {
                                            //TODO
                                            if self.mViewModel.IsLoading == false {
                                                if self.mViewModel.Data.Elements.count < self.mViewModel.Data.Total {
                                                    if  invoice == self.mViewModel.Data.Elements.last {
                                                        self.mViewModel.mSkipCount = self.mViewModel.Data.Elements.count
                                                        self.mViewModel.loadData()
                                                   }
                                                }
                                            }
                                        }
                                    }
                                }
                                .listStyle(PlainListStyle())
                                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                                ZStack {
                                    ToastView($ToastMessage)
                                }
                            }
                        }
                    }
                }
                .background(Color.primary)
            }
        }
        .onAppear {
            if self.mViewModel.Data.Elements.count == 0 {
                self.loadData()
            }
        }
        .onChange(of: self.ActionResult) { newValue in
            if newValue != nil {
                switch(newValue!) {
                    case OperationResult.Create:
                        self.ToastMessage = NSLocalizedString("message_save_success", comment: "")
                        self.loadData()
                    case OperationResult.Update:
                        self.loadData()
                    default: ()
                }
            }
        }
    }
 
    private func loadData() {
        self.mViewModel.clearData()
        self.mViewModel.loadData()
    }
    
    private func setFilter(filterIndex: Int, filter: String) {
        self.mCurrentFilter = filterIndex
        self.mViewModel.setFilter(filter)
        self.loadData()
    }
}
