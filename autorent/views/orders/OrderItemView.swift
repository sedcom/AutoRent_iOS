//
//  OrderItemView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 21.01.2022.
//

import SwiftUI

struct OrderItemView: View {
    var mOrderItem: OrderItem
    var mIndex: Int
    
    init(orderItem: OrderItem, index: Int) {
        self.mOrderItem = orderItem
        self.mIndex = index
    }
    
    var body: some View {
        VStack {
            VStack {
                VStack {
                    CustomText(String(format: NSLocalizedString("string_orderitem_title", comment: ""), String(self.mIndex + 1)), alignment: .trailing, maxLines: 1, bold: true)
                }
                HStack {
                    HStack {
                        Image("calendar-alt")
                            .resizable()
                            .frame(width: 30, height: 35)
                            .foregroundColor(Color.textLight)
                        VStack {
                            CustomText(Utils.formatDate(format: "dd MMMM yyyy", date: self.mOrderItem.StartDate), alignment: .center, maxLines: 1)
                            CustomText(Utils.formatDate(format: "HH:mm ZZZZZ", date: self.mOrderItem.StartDate), alignment: .center, maxLines: 1, bold: true)
                         }
                     }
                     .frame(maxWidth: .infinity, alignment: .center)
                     .padding(EdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8))
                     .background(Color.primary)
                     HStack {
                        Image("calendar-alt")
                            .resizable()
                            .frame(width: 30, height: 35)
                            .foregroundColor(Color.textLight)
                        VStack {
                            CustomText(Utils.formatDate(format: "dd MMMM yyyy", date: self.mOrderItem.FinishDate), alignment: .center, maxLines: 1)
                            CustomText(Utils.formatDate(format: "HH:mm ZZZZZ", date: self.mOrderItem.FinishDate), alignment: .center, maxLines: 1, bold: true)
                         }
                     }
                     .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                     .padding(EdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8))
                     .background(Color.primary)
                 }
                VStack {
                    CustomText(String(format: "%@ / %@ %@ (%@)", self.mOrderItem.Vehicle.VehicleType!.getVehicleTypeName(), self.mOrderItem.Vehicle.Producer!, self.mOrderItem.Vehicle.Model!, String(format: NSLocalizedString("string_vehicle_regnumber_text", comment: ""), self.mOrderItem.Vehicle.RegNumber!)), image: "truck-monster")
                }
                HStack {
                    CustomText(String(format: "%@ %@", String(self.mOrderItem.getOrderItemHours()), NSLocalizedString("string_hour", comment: "")), image: "clock")
                    CustomText(String(format: "%.2f", self.mOrderItem.getOrderItemSumma()), alignment: .trailing, image: "ruble-sign")
                }
             }
             .padding(.all, 12)
         }
         .frame(minWidth: 0, maxWidth: .infinity)
         .background(Color.primaryDark)
         .cornerRadius(5)
    }
}
