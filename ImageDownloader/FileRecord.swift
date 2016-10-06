//
//  FileRecord.swift
//  ImageDownloader
//
//  Created by Ha Lam on 10/5/16.
//  Copyright © 2016 HTKInc. All rights reserved.
//

import Foundation

/*
 This protocol for reloadData
 */

protocol FileRecordDelegate: class {
    func reloadData(_ index: IndexPath)
}

/*
 This enum for state of FileRecord
 */

enum FileState: String {
    case Queueing
    case Unzipping
    case Downloading
    case Finished
    case Error
}

/*
 This class for FileRecord model
 */

class FileRecord {
    
    //MARK: varible
    private(set) var fileName: String
    private(set) var fileState: String {
        didSet {
            delegate?.reloadData(index!)
        }
    }
    private(set) var files: [String]
    private(set) var fileUrl: URL?
    weak var delegate: FileRecordDelegate?
    private(set) var index: IndexPath?
    private(set) var activeDownload = [String:LHNetWork]()
    fileprivate var countDown = 0
    
    //MARK: function
    
    init() {
        self.files = [String]()
        self.fileName = ""
        self.fileState = FileState.Queueing.rawValue + "..."
    }
    
    //get json file
    func parseJson(_ urlPaths: [URL]) -> [FileRecord] {
        var records = [FileRecord]()
        for path in urlPaths {
            let file = FileRecord()
            file.fileName = URL.getFileName(path)
            file.fileUrl = path
            records.append(file)
        }
        return records
    }
    
    //parse data in json file
    func parseDataInJsonFile(_ index: IndexPath) {
        self.index = index
        self.fileState = FileState.Unzipping.rawValue + "..."
        guard let jsonData = try? Data(contentsOf: self.fileUrl!, options: .mappedIfSafe) else {
            return
        }
        guard let jsonResult = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) else {
            return
        }
        //remove duplicate value in array
        var arrayOfFiles = jsonResult as! [String]
        let setOfFiles = Set(arrayOfFiles)
        arrayOfFiles = Array(setOfFiles)
        self.files = arrayOfFiles
    }
    
    func downLoadFiles() {
        //note: IndexPath
        self.fileState = FileState.Downloading.rawValue + "..."
        for path in self.files {
            let nwCall = LHNetWork(path, self)
            nwCall.downloadFile()
            self.activeDownload[path] = nwCall
        }
    }
    
    fileprivate func setFileStateFinish(_ isError: Bool = false){
        self.fileState = isError ? FileState.Error.rawValue : FileState.Finished.rawValue
    }
}

extension FileRecord: LHDownloadDelegate {
    func downLoadDidFinishSuccess() {
        self.countDown += 1
        if self.countDown >= self.activeDownload.count {
            self.setFileStateFinish()
        }
        print("===> At \(self.fileName) + Number of File: \(self.countDown) + Total: \(self.activeDownload.count) \n")
    }
    
    func downLoadError() {
        self.countDown += 1
        if self.countDown >= self.activeDownload.count {
            self.setFileStateFinish(true)
        }
    }
}













