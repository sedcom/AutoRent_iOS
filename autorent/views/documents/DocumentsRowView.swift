//
//  DocumentsRowView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 21.01.2022.
//

import SwiftUI

struct DocumentsRowView: View {
    var mOrder: Order
    var mDocument: Document
    
    init (_ order: Order, _ document: Document) {
        self.mOrder = order
        self.mDocument = document
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    CustomText(String(format: NSLocalizedString("title_document", comment: ""), self.mDocument.DocumentType!.Name, self.mDocument.Number!), maxLines: 1, bold: true)
                    CustomText(Utils.formatDate(format: "dd MMMM yyyy", date: self.mDocument.Date!), alignment: .trailing, maxLines: 1, bold:true, image: "calendar-alt")
                }
                .padding(.bottom, 8)
                VStack {
                    CustomText(self.mOrder.Company!.getCompanyName(), image: "address-book")
                }
                VStack {
                    CustomText(self.mOrder.Application!.Address!.getAddressName(), image: "map-marker-alt")
                }
                VStack {
                    CustomText(self.mOrder.Application!.getVehicles(), image: "truck-monster")
                }
                .padding(.bottom, 8)
                HStack {
                    CustomText(self.mDocument.getStatus().Status.Name, maxLines: 1)
                    CustomText(Utils.formatDate(format: "dd.MM.yyyy HH:mm", date: self.mDocument.getStatus().CreatedDate), alignment: .trailing, maxLines: 1)
                }
            }
            .padding(.all, 8)
        }
        .background(Color.primaryDark)
        .cornerRadius(5)
        .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
    }
}
