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
                    CustomText(String(format: NSLocalizedString("title_application", comment: ""), String(self.mApplication.Id)), maxLines: 1, bold: true)
                    CustomText(Utils.formatDate(format: "dd MMMM yyyy", date: self.mApplication.CreatedDate), alignment: .trailing, maxLines: 1, bold:true, image: "calendar-alt")
                }
                .padding(.bottom, 8)
                VStack {
                    if self.mApplication.Company == nil {
                        CustomText(self.mApplication.User.Profile.getUserName(), image: "user")
                    }
                    else {
                        CustomText(self.mApplication.Company!.getCompanyName(), image: "address-book")
                    }
                }
                VStack {
                    CustomText(self.mApplication.Address.getAddressName(), image: "map-marker-alt")
                }
                VStack {
                    CustomText(self.mApplication.getVehicles(), image: "truck-monster")
                }
                .padding(.bottom, 8)
                HStack {
                    CustomText(self.mApplication.getStatus().Status.Name, maxLines: 1)
                    CustomText(Utils.formatDate(format: "dd.MM.yyyy HH:mm", date: self.mApplication.getStatus().CreatedDate), alignment: .trailing, maxLines: 1)
                }
            }
            .padding(.all, 8)
        }
        .background(Color.primaryDark)
        .cornerRadius(5)
        .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
    }

}
