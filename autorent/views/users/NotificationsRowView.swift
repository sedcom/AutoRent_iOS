//
//  NotificationsRowView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 23.01.2022.
//

import SwiftUI

struct NotificationsRowView: View {
    var mNotification: UserNotification
    
    init (_ notification: UserNotification) {
        self.mNotification = notification
    }
    
    var body: some View {
        VStack {
            VStack {
                CustomText(Utils.formatDate(format: "dd MMMM yyyy", date: self.mNotification.CreatedDate), maxLines: 1, image: "calendar-alt")
                HStack(spacing: 10) {
                    Image(self.mNotification.Marked ? "envelope-open" : "envelope")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.textLight)
                    CustomText(self.mNotification.formatMessage())
                }
            }
            .padding(.all, 8)
        }
        .background(Color.primaryDark)
        .cornerRadius(5)
        .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
    }
}

