//
//  CompaniesRowView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 11.02.2022.
//

import SwiftUI

struct CompaniesRowView: View {
    var mCompany: Company
    
    init (_ company: Company) {
        self.mCompany = company
    }
    
    var body: some View {
        VStack {
            VStack {                
                CustomText(self.mCompany.getCompanyName(), image: "address-book")
                CustomText(self.mCompany.Addresses.first?.getAddressName() ?? "", image: "map-marker-alt")
            }
            .padding(.all, 8)
        }
        .background(Color.primaryDark)
        .cornerRadius(5)
        .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
    }
}
