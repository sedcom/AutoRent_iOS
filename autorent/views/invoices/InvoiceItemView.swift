//
//  InvoiceItemView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 23.01.2022.
//

import SwiftUI

struct InvoiceItemView: View {
    var mInvoiceItem: InvoiceItem
    var mIndex: Int
    
    init(invoiceItem: InvoiceItem, index: Int) {
        self.mInvoiceItem = invoiceItem
        self.mIndex = index
    }
    
    var body: some View {
        VStack {
            VStack {
                VStack {
                    CustomText(String(format: NSLocalizedString("string_invoiceitem_title", comment: ""), String(self.mIndex + 1)), alignment: .trailing, maxLines: 1, bold: true)
                }
                HStack {
                    CustomText(self.mInvoiceItem.Name)
                    CustomText(String(self.mInvoiceItem.Summa), alignment: .trailing, image: "ruble-sign")
                }
             }
             .padding(.all, 12)
         }
         .frame(minWidth: 0, maxWidth: .infinity)
         .background(Color.primaryDark)
         .cornerRadius(5)
    }
}
