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
    let mSize: Int?
    let mColor: Color?
    let mImage: String?
    
    init(_ text: String, alignment: Alignment = .leading, maxLines: Int? = nil, bold: Bool = false,  size: Int? = 16, color: Color = Color.textLight, image: String? = nil) {
        self.mText = NSLocalizedString(text, comment: "")
        self.mAlignment = alignment
        self.mMaxLines = maxLines
        self.mBold = bold
        self.mImage = image
        self.mSize = size
        self.mColor = color
    }
    
    var body: some View {
        HStack(spacing: 8) {
            if mImage != nil {
                Image(self.mImage!)
                    .foregroundColor(self.mColor)
            }
            Text(self.mText)
                .foregroundColor(self.mColor)
                .font(.system(size: CGFloat(self.mSize!), weight: self.mBold ? .bold : .regular))
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(self.mMaxLines)
        }
        .frame(maxWidth: .infinity, alignment: self.mAlignment)
    }
}
