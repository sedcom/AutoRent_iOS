//
//  FileView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 11.02.2022.
//

import Foundation
import SwiftUI
import PDFKit
import MobileCoreServices
import UniformTypeIdentifiers

struct FileView: View {
    var mFile: File
    var mMimeType: String
    
    init(file: File) {
        self.mFile = file
        self.mMimeType = UTType(filenameExtension: URL(fileURLWithPath: file.Name).pathExtension)?.preferredMIMEType ?? ""
    }
    
    var body: some View {
        VStack {
            if self.mMimeType == "application/pdf"{
                PDFViewer(file: self.mFile)
            }
            else if self.mMimeType.hasPrefix("image") {
                Image(uiImage: UIImage(data: Data(self.mFile.Content))!)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.all, 8)
                    .background(Color.primary)
            }
            else {
                CustomText("message_preview_error", alignment: .center)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.primary)
            }
        }
        .background(Color.primary.edgesIgnoringSafeArea(.all))
        .navigationBarHidden(false)
        .navigationBarTitle(self.mFile.Name, displayMode: .inline)
    }
}

struct PDFViewer: UIViewRepresentable {
    var mFile: File
    
    init(file: File) {
        self.mFile = file
    }
    
    func makeUIView(context: Context) -> some UIView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(data: Data(self.mFile.Content))
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}








