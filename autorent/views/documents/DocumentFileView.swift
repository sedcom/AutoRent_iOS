//
//  DocumentFileView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 23.01.2022.
//

import SwiftUI

struct DocumentFileView: View {
    var mFile: File
    
    init(file: File) {
        self.mFile = file
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image("iconmonstr-file")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.textLight)
                    VStack {
                        CustomText(self.mFile.Name)
                        CustomText(Utils.formatFileSize(size: self.mFile.Content.count))
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
