//
//  ApplicationsRowView.swift
//  autorent
//
//  Created by Semyon Kravchenko on 30.11.2021.
//

import SwiftUI

struct ApplicationsRowView: View {
    var mApplication: Application
    
    init (_ application: Application) {
        self.mApplication = application
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Заявка №\(self.mApplication.Id)")
                        .foregroundColor(Color.textLight)
                        .font(Font.headline.weight(.bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                    HStack(spacing: 8) {
                        Image("calendar-alt")
                            .renderingMode(.template)
                            .foregroundColor(Color.textLight)
                        Text(Utils.formatDate(format: "dd MMMM yyyy", date: self.mApplication.CreatedDate))
                            .foregroundColor(Color.textLight)
                            .font(Font.headline.weight(.bold))
                            .frame(alignment: .trailing)
                            .lineLimit(1)
                    }
                }
                .padding(.bottom, 8)
                HStack {
                    Image("user")
                        .renderingMode(.template)
                        .foregroundColor(Color.textLight)
                    Text(self.mApplication.User.Profile.getUserName())
                        .foregroundColor(Color.textLight)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                HStack {
                    Image("map-marker-alt")
                        .renderingMode(.template)
                        .foregroundColor(Color.textLight)
                    Text(self.mApplication.Address.getAddressName())
                        .foregroundColor(Color.textLight)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                HStack {
                    Image("truck-monster")
                        .renderingMode(.template)
                        .foregroundColor(Color.textLight)
                    Text(self.mApplication.getVehicles())
                        .foregroundColor(Color.textLight)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.bottom, 8)
                HStack {
                    Text(self.mApplication.getStatus())
                        .foregroundColor(Color.textLight)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                   Text(Utils.formatDate(format: "dd.MM.yyyy HH:mm", date: self.mApplication.CreatedDate))
                        .foregroundColor(Color.textLight)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .lineLimit(1)
                }
            }
            .padding(.all, 8)
        }
        .background(Color.primaryDark)
        .cornerRadius(5)
        .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
    }

}
