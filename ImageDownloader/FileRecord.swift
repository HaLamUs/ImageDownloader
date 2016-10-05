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
}

/*
 This class for FileRecord model
 */

class FileRecord {
    
    //MARK: varible
    private(set) var fileName: String
    private(set) var fileState: String
        {
        didSet {
            delegate?.reloadData(index!)
        }
    }
    private(set) var files: [String]
    private(set) var fileUrl: URL?
    weak var delegate: FileRecordDelegate?
    private(set) var index: IndexPath?
    
    //MARK: function
    //init
    init() {
        self.files = [String]()
        self.fileName = ""
        self.fileState = FileState.Queueing.rawValue + "..."
    }
    
    //get json file
    func parseJson(_ urlPaths: [URL]) -> [FileRecord] {
        var records = [FileRecord]()
        let file = FileRecord()
        for path in urlPaths {
            file.fileName = URL.getFileName(path)
            file.fileUrl = path
            records.append(file)
        }
        return records
    }
    
    //parse data in json file
    func parseDataInJsonFile(_ index: IndexPath) {
        self.index = index
        self.fileState = FileState.Queueing.rawValue + "..."
        guard let jsonData = try? Data(contentsOf: fileUrl!, options: .mappedIfSafe) else {
            return
        }
        guard let jsonResult = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) else {
            return
        }
        self.files = jsonResult as! [String]
    }
    
    func downLoadFiles() {
        for path in self.files{
            let nwCall = LHNetWork(path, self)
            nwCall.downloadFile()
        }
    }
}

extension FileRecord: LHDownloadDelegate {
    func downLoadDidFinish() {
        print()//cai nay hit 99 lan ha
    }
}













