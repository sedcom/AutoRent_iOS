//
//  DocumentFileView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 23.01.2022.
//

import SwiftUI
import UniformTypeIdentifiers

struct DocumentFileView: View {
    @ObservedObject var mViewModel: FileViewModel
    var mFile: File
    @Binding var isFileOperationSuccessed: Bool?
        
    init(file: File, isFileOperationSuccessed: Binding<Bool?>) {
        self.mFile = file
        self._isFileOperationSuccessed = isFileOperationSuccessed
        self.mViewModel = FileViewModel(entityId: file.Id, file: file)
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    NavigationLink(destination: FileView(file: self.mFile)) {
                        Image((UTType(filenameExtension: URL(fileURLWithPath: self.mFile.Name).pathExtension)?.preferredMIMEType ?? "") == "application/pdf" ? "iconmonstr-file-pdf" : (UTType(filenameExtension: URL(fileURLWithPath: self.mFile.Name).pathExtension)?.preferredMIMEType?.hasPrefix("image") ?? false) ? "iconmonstr-file-image" : "iconmonstr-file")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.textLight)
                    }
                    VStack {
                        CustomText(self.mFile.Name)
                        CustomText(Utils.formatFileSize(size: self.mFile.Content.count))
                    }
                    Image("iconmonstr-download")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.textLight)
                        .onTapGesture {
                            self.mViewModel.saveFile()
                        }
                }
            }
            .padding(.all, 12)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color.primaryDark)
        .cornerRadius(5)
        .onChange(of: self.mViewModel.isFileOperationSuccessed) { newValue in
            if newValue != nil {
                self.isFileOperationSuccessed = newValue
                self.mViewModel.isFileOperationSuccessed = nil
            }
        }
    }
}
