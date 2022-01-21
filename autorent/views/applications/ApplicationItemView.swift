//
//  ApplicationItemView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 05.01.2022.
//

import SwiftUI

struct ApplicationItemView: View {
    var mApplicationItem: ApplicationItem
    var mIndex: Int
    
    init(applicationItem: ApplicationItem, index: Int) {
        self.mApplicationItem = applicationItem
        self.mIndex = index
    }
    
    var body: some View {
        VStack {
            VStack {
                VStack {
                    CustomText(String(format: NSLocalizedString("string_applicationitem_title", comment: ""), String(self.mIndex + 1)), alignment: .trailing, maxLines: 1, bold: true)
                }
                HStack {
                    HStack {
                        Image("calendar-alt")
                            .resizable()
                            .frame(width: 30, height: 35)
                            .foregroundColor(Color.textLight)
                        VStack {
                            CustomText(Utils.formatDate(format: "dd MMMM yyyy", date: self.mApplicationItem.StartDate), alignment: .center, maxLines: 1)
                            CustomText(Utils.formatDate(format: "HH:mm ZZZZZ", date: self.mApplicationItem.StartDate), alignment: .center, maxLines: 1, bold: true)
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
                            CustomText(Utils.formatDate(format: "dd MMMM yyyy", date: self.mApplicationItem.FinishDate), alignment: .center, maxLines: 1)
                            CustomText(Utils.formatDate(format: "HH:mm ZZZZZ", date: self.mApplicationItem.FinishDate), alignment: .center, maxLines: 1, bold: true)
                         }
                     }
                     .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                     .padding(EdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8))
                     .background(Color.primary)
                 }
                VStack {
                    CustomText(self.mApplicationItem.VehicleParams.VehicleType.getVehicleTypeName(), image: "truck-monster")
                }
                VStack {
                    ForEach(self.mApplicationItem.VehicleParams.VehicleOptions) { option in
                        if option.getOptionValue() != nil {
                            HStack {
                                CustomText(option.VehicleOption.VehicleOptionType.Name, image: "iconmonstr-gear")
                                CustomText(option.getOptionValue()!, bold: true)
                            }
                        }
                    }
                }
             }
             .padding(.all, 12)
         }
         .frame(minWidth: 0, maxWidth: .infinity)
         .background(Color.primaryDark)
         .cornerRadius(5)
    }
}
