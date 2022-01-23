//
//  OrdersRowView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 21.01.2022.
//

import SwiftUI

struct OrdersRowView: View {
    var mOrder: Order
    
    init (_ order: Order) {
        self.mOrder = order
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    CustomText(String(format: NSLocalizedString("title_order", comment: ""), String(self.mOrder.Id)), maxLines: 1, bold: true)
                    CustomText(Utils.formatDate(format: "dd MMMM yyyy", date: self.mOrder.CreatedDate), alignment: .trailing, maxLines: 1, bold:true, image: "calendar-alt")
                }
                .padding(.bottom, 8)
                VStack {
                    if self.mOrder.getStatus(statusId: 3) || self.mOrder.getStatus(statusId: 4) {
                        if self.mOrder.Application!.Company == nil {
                            CustomText(self.mOrder.Application!.User!.Profile.getUserName(), image: "user")
                        }
                        else {
                            CustomText(self.mOrder.Application!.Company!.getCompanyName(), image: "address-book")
                        }
                    }
                }
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
                    CustomText(self.mOrder.getStatus().Status.Name, maxLines: 1)
                    CustomText(Utils.formatDate(format: "dd.MM.yyyy HH:mm", date: self.mOrder.getStatus().CreatedDate), alignment: .trailing, maxLines: 1)
                }
            }
            .padding(.all, 8)
        }
        .background(Color.primaryDark)
        .cornerRadius(5)
        .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
    }
}
