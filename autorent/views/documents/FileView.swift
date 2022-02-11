//
//  FileView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 11.02.2022.
//

import SwiftUI
import PDFKit

struct FileView: View {
    var mFile: File
    
    init(file: File) {
        self.mFile = file
    }
    
    var body: some View {
        VStack {
            PDFViewer(file: self.mFile)
            
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








