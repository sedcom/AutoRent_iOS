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
        NavigationLink(destination: ApplicationView(entityId: self.mApplication.Id))  { }
            .frame(width: 0, height: 0)
        VStack {
            VStack {
                HStack {
                    Text("Заявка №" + String(self.mApplication.Id))
                        .foregroundColor(Color.textLight)
                        .font(Font.headline.weight(.bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                    HStack {
                        Image("calendar-alt")
                            .renderingMode(.template)
                            .foregroundColor(Color.textLight)
                        Text(Utils.formatDate(format: "dd MMMM yyyy", date: self.mApplication.CreatedDate))
                            .foregroundColor(Color.textLight)
                            .font(Font.headline.weight(.bold))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .lineLimit(1)
                    }
                }
                .padding(.bottom, 4)
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
                .padding(.bottom, 4)
                HStack {
                    Image("truck-monster")
                        .renderingMode(.template)
                        .foregroundColor(Color.textLight)
                    Text(self.mApplication.getVehicles())
                        .foregroundColor(Color.textLight)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.bottom, 4)
            }
            .padding(.all, 8)
        }
        .background(Color.primaryDark)
        .cornerRadius(5)
    }
}
