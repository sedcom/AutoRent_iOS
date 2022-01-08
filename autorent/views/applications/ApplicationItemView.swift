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
                Text("Position #\(self.mIndex)")
                     .foregroundColor(Color.textLight)
                     .font(Font.headline.weight(.bold))
                     .frame(maxWidth: .infinity, alignment: .trailing)
                 HStack {
                     HStack {
                         Image("calendar-alt")
                             .renderingMode(.template)
                             .resizable()
                             .foregroundColor(Color.textLight)
                             .frame(width: 30, height: 35)
                         VStack {
                            Text(Utils.formatDate(format: "dd MMMM yyyy", date: self.mApplicationItem.StartDate))
                                 .foregroundColor(Color.textLight)
                                 .lineLimit(1)
                             Text(Utils.formatDate(format: "HH:mm ZZZZZ", date: self.mApplicationItem.StartDate))
                                 .foregroundColor(Color.textLight)
                                 .font(Font.headline.weight(.bold))
                                 .lineLimit(1)
                         }
                     }
                     .padding(EdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8))
                     .frame(minWidth: 0, maxWidth: .infinity)
                     .background(Color.primary)
                     HStack {
                         Image("calendar-alt")
                             .renderingMode(.template)
                             .resizable()
                             .foregroundColor(Color.textLight)
                             .frame(width: 30, height: 35)
                         VStack {
                             Text(Utils.formatDate(format: "dd MMMM yyyy", date: self.mApplicationItem.FinishDate))
                                 .foregroundColor(Color.textLight)
                                .lineLimit(1)
                             Text(Utils.formatDate(format: "HH:mm ZZZZZ", date: self.mApplicationItem.FinishDate))
                                 .foregroundColor(Color.textLight)
                                 .font(Font.headline.weight(.bold))
                                .lineLimit(1)
                         }
                     }
                     .padding(EdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8))
                     .frame(minWidth: 0, maxWidth: .infinity)
                     .background(Color.primary)
                 }
                 HStack {
                     Image("truck-monster")
                         .renderingMode(.template)
                         .foregroundColor(Color.textLight)
                    Text(self.mApplicationItem.VehicleParams.VehicleType.getVehicleTypeName())
                         .foregroundColor(Color.textLight)
                         .fixedSize(horizontal: false, vertical: true)
                         .frame(maxWidth: .infinity, alignment: .leading)
                 }
                 ForEach(self.mApplicationItem.VehicleParams.VehicleOptions) { option in
                     if option.getOptionValue() != nil {
                         HStack {
                             Image("iconmonstr-gear")
                                 .renderingMode(.template)
                                 .foregroundColor(Color.textLight)
                             Text(option.VehicleOption.VehicleOptionType.Name)
                                 .foregroundColor(Color.textLight)
                                 .fixedSize(horizontal: false, vertical: true)
                                 .frame(maxWidth: .infinity, alignment: .leading)
                             Text(option.getOptionValue()!)
                                 .foregroundColor(Color.textLight)
                                 .font(Font.headline.weight(.bold))
                                 .fixedSize(horizontal: false, vertical: true)
                                 .frame(maxWidth: .infinity, alignment: .leading)
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
