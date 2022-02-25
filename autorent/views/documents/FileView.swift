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
import QuickLook

struct FileView: View {
    var mFile: File
    var mMimeType: String
    @ObservedObject var mViewModel: FileViewModel
    @State var localPath: String?
    @State var isFileOperationSuccessed: Bool?
    @State var ToastMessage: String?
    
    init(file: File) {
        self.mFile = file
        self.mMimeType = UTType(filenameExtension: URL(fileURLWithPath: file.Name).pathExtension)?.preferredMIMEType ?? ""
        self.mViewModel = FileViewModel(entityId: file.Id, file: file)
    }
    
    var body: some View {
        ZStack {
            VStack {
                if self.mMimeType == "application/pdf" {
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
                    if self.localPath != nil {
                        PreviewController(url: URL(fileURLWithPath: self.localPath!))
                    }
                    else {
                        CustomText("message_preview_error", alignment: .center)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.primary)
                    }
                }
            }
            .background(Color.primary.edgesIgnoringSafeArea(.all))
            .navigationBarHidden(false)
            .navigationBarTitle(self.mFile.Name, displayMode: .inline)
            .navigationBarItems(trailing:
                HStack(spacing: 10) {
                    Image("iconmonstr-download")
                        .renderingMode(.template)
                        .foregroundColor(Color.textLight)
                        .onTapGesture {
                            self.mViewModel.saveFile()
                        }
                })
            .onChange(of: self.mViewModel.localPath) { newValue in
                if newValue != nil {
                    self.localPath = newValue
                    self.mViewModel.localPath = nil
                }
            }
            .onChange(of: self.mViewModel.isFileOperationSuccessed) { newValue in
                if newValue != nil {
                    self.isFileOperationSuccessed = newValue
                    self.mViewModel.isFileOperationSuccessed = nil
                }
            }
            .onChange(of: self.isFileOperationSuccessed) { newValue in
                if newValue != nil {
                    self.ToastMessage = NSLocalizedString(newValue! ? "message_download_success" : "message_download_error", comment: "")
                    self.isFileOperationSuccessed = nil
                }
            }
            .onAppear() {
                if !(self.mMimeType == "application/pdf" || self.mMimeType.hasPrefix("image")) {
                    self.mViewModel.saveFileToPreview()
                }
            }
            .onDisappear() {
                if self.localPath != nil {
                    self.mViewModel.deleteFile(filePath: self.localPath!)
                    self.localPath = nil
                }
            }
            ToastView($ToastMessage)
        }
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

struct PreviewController: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> QLPreviewController {
        let controller = QLPreviewController()
        controller.dataSource = context.coordinator
        return controller
    }
    
    func updateUIViewController(
        _ uiViewController: QLPreviewController, context: Context) {
    }
    
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: QLPreviewControllerDataSource {
        let parent: PreviewController
        
        init(parent: PreviewController) {
            self.parent = parent
        }
        
        func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
            return 1
        }
        
        func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
            return parent.url as NSURL
        }
    }
}
