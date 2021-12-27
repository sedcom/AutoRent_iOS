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
        NavigationLink(destination: ApplicationView(entityId: self.mApplication.Id)) {
            VStack {
                HStack {
                    Text("Заявка №" + String(self.mApplication.Id))
                        .foregroundColor(Color.textLight).padding()
                    Text(Utils.formatDate(format: "dd MMMM yyyy", date: self.mApplication.CreatedDate))
                        .foregroundColor(Color.textLight)
                        
                }
                .padding(.all, 4)
                HStack {
                    Text(self.mApplication.User.Profile.FirstName)
                        .foregroundColor(Color.textLight)
                }
                .padding(.all, 4)
            }
        }
        .background(Color.primaryDark)
        .cornerRadius(5)
    }
}
