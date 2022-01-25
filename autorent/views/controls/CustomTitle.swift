//
//  CustomTitle.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 25.01.2022.
//

import SwiftUI

struct CustomTitle: View {
    let mTitle: String
    let mSubtitle: String
    
    init(title: String, subtitle: String?) {
        self.mTitle = NSLocalizedString(title, comment: "")
        self.mSubtitle = NSLocalizedString(subtitle ?? "", comment: "")
    }
    
    var body: some View {
        VStack {
            Text(self.mTitle)
                .foregroundColor(Color.textLight)
                .font(.system(size: 18, weight: .bold, design: .default))
                .lineLimit(1)
            Text(self.mSubtitle)
                .foregroundColor(Color.textLight)
                .font(.system(size: 14, weight: .regular, design: .default))
                .lineLimit(1)
        }
        .padding(.top, 8)
        .padding(.bottom, 8)
    }
}



