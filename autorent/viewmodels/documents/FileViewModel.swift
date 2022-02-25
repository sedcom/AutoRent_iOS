//
//  FileViewModel.swift
//  autorent
//
//  Created by Semyon Kravchenko on 21.02.2022.
//

import Foundation

class FileViewModel: ObservableObject {
    var File: File?
    var mEntityId: Int
    var localPath: String?
    var isFileOperationSuccessed: Bool?
    
    init(entityId: Int, file: File) {
        self.File = file
        self.mEntityId = entityId
    }
    
    public func saveFile() {
        debugPrint("Start saveFile")
        var isDirectory : ObjCBool = true
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
                self.isFileOperationSuccessed = false
                self.objectWillChange.send()
                return
            }
        let fileUrl =  directory.appendingPathComponent(        String(format: "%@ (id %@).%@", (self.File!.Name as NSString).deletingPathExtension, String(self.mEntityId), (self.File!.Name as NSString).pathExtension))
        if !FileManager.default.fileExists(atPath: directory.path, isDirectory: &isDirectory) {
                do {
                    try FileManager.default.createDirectory(atPath: directory.path, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    self.isFileOperationSuccessed = false
                    self.objectWillChange.send()
                    return
                }
        }
        if FileManager.default.fileExists(atPath: fileUrl.path) {
            do {
                try FileManager.default.removeItem(atPath: fileUrl.path)
            } catch {
                self.isFileOperationSuccessed = false
                self.objectWillChange.send()
                return
            }
        }
        do{
            try Data(self.File!.Content).write(to: fileUrl, options: .atomic)
            debugPrint("Finish saveFile")
            self.isFileOperationSuccessed = true
            self.objectWillChange.send()
        }
        catch {
            self.isFileOperationSuccessed = false
            self.objectWillChange.send()
        }
    }
    
    public func saveFileToPreview() {
        debugPrint("Start saveFileToPreview")
        var isDirectory : ObjCBool = true
        guard let directory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).last else {
                return
            }
        let fileUrl =  directory.appendingPathComponent(        String(format: "%@ (id %@).%@", (self.File!.Name as NSString).deletingPathExtension, String(self.mEntityId), (self.File!.Name as NSString).pathExtension))
        if !FileManager.default.fileExists(atPath: directory.path, isDirectory: &isDirectory) {
                do {
                    try FileManager.default.createDirectory(atPath: directory.path, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    return
                }
        }
        if FileManager.default.fileExists(atPath: fileUrl.path) {
            do {
                try FileManager.default.removeItem(atPath: fileUrl.path)
            } catch {
                return
            }
        }
        do{
            try Data(self.File!.Content).write(to: fileUrl, options: .atomic)
            debugPrint("Finish saveFileToPreview")
            self.localPath = fileUrl.path
            self.objectWillChange.send()
        }
        catch {
        }
    }
    
    public func deleteFile(filePath: String) {
        debugPrint("Start deleteFile")
        if FileManager.default.fileExists(atPath: filePath) {
            do {
                try FileManager.default.removeItem(atPath: filePath)
                debugPrint("Finish deleteFile")
            } catch {
            }
        }
    }
}
