//
//  InvoicesRowView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 22.01.2022.
//

import SwiftUI

struct InvoicesRowView: View {
    var mInvoice: Invoice
    
    init (_ invoice: Invoice) {
        self.mInvoice = invoice
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    CustomText(String(format: NSLocalizedString("title_invoice", comment: ""), self.mInvoice.InvoiceType!.Name, self.mInvoice.Number!), maxLines: 1, bold: true)
                    CustomText(Utils.formatDate(format: "dd MMMM yyyy", date: self.mInvoice.Date!), alignment: .trailing, maxLines: 1, bold:true, image: "calendar-alt")
                }
                .padding(.bottom, 8)
                VStack {
                    if self.mInvoice.Document!.Order!.Application!.Company == nil {
                        CustomText(self.mInvoice.Document!.Order!.Application!.User!.Profile.getUserName(), image: "user")
                    }
                    else {
                        CustomText(self.mInvoice.Document!.Order!.Application!.Company!.getCompanyName(), image: "address-book")
                    }
                }
                VStack {
                    CustomText(self.mInvoice.Document!.Order!.Company!.getCompanyName(), image: "address-book")
                }
                VStack {
                    CustomText(String(format: NSLocalizedString("title_document", comment: ""), self.mInvoice.Document!.DocumentType!.Name, self.mInvoice.Document!.Number!), image: "file-signature")
                }
                .padding(.bottom, 8)
                HStack {
                    CustomText(self.mInvoice.getStatus().Status.Name, maxLines: 1)
                    CustomText(Utils.formatDate(format: "dd.MM.yyyy HH:mm", date: self.mInvoice.getStatus().CreatedDate), alignment: .trailing, maxLines: 1)
                }
            }
            .padding(.all, 8)
        }
        .background(Color.primaryDark)
        .cornerRadius(5)
        .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
    }
}
