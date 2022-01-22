//
//  CustomText.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 20.01.2022.
//

import SwiftUI

struct CustomText: View {
    let mText: String
    let mAlignment: Alignment
    let mMaxLines: Int?
    let mBold: Bool
    let mImage: String?
    let mSelected: Bool
    
    init(_ text: String, alignment: Alignment = .leading, maxLines: Int? = nil, bold: Bool = false, image: String? = nil, selected: Bool = false) {
        self.mText = NSLocalizedString(text, comment: "")
        self.mAlignment = alignment
        self.mMaxLines = maxLines
        self.mBold = bold
        self.mImage = image
        self.mSelected = selected
    }
    
    var body: some View {
        HStack(spacing: 8) {
            if mImage != nil {
                Image(self.mImage!)
                    .foregroundColor(self.mSelected ? Color.textDark : Color.textLight)
            }
            Text(self.mText)
                .foregroundColor(self.mSelected ? Color.textDark : Color.textLight)
                .font(Font.headline.weight(self.mBold ? .bold : .regular))                
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(self.mMaxLines)
        }
        .frame(maxWidth: .infinity, alignment: self.mAlignment)
    }
}


