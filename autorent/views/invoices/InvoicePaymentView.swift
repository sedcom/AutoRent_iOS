//
//  InvoicePaymentView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 11.02.2022.
//

import SwiftUI
import WebKit

struct InvoicePaymentView: View {
    var mEntityId: Int
    var mTitle: String
    
    init(entityId: Int, title: String) {
        self.mEntityId = entityId
        self.mTitle = title
    }
    
    var body: some View {
        VStack {
            InvoicePaymentViewer(invoiceId: self.mEntityId)
        }
        .background(Color.primary.edgesIgnoringSafeArea(.all))
        .navigationBarHidden(false)
        .navigationBarTitle(self.mTitle, displayMode: .inline)
    }
}

struct InvoicePaymentViewer: UIViewRepresentable {
    var mInvoiceId: Int
    var MerchURL: String = "https://lt.pga.gazprombank.ru/pages"
    var MerchId: String = "MAKNKI6GR8I8R2A74LMD39YI2KI2Q68H"
    
    init(invoiceId: Int) {
        self.mInvoiceId = invoiceId
    }
    
    func makeUIView(context: Context) -> some WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        let user = AuthenticationService.getInstance().getCurrentUser()
        let url = String(format: "%@?merch_id=%@&back_url_s=%@&back_url_f=%@&o.invoice_id=%@&o.user_id=%@", self.MerchURL, self.MerchId, "https://", "https://", String(self.mInvoiceId), String(user!.Id))
        uiView.load(URLRequest(url: URL(string: url)!))
    }
}
