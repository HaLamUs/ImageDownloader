//
//  FileRecord.swift
//  ImageDownloader
//
//  Created by Ha Lam on 10/5/16.
//  Copyright © 2016 HTKInc. All rights reserved.
//

import Foundation

/*
 This struct for FileRecord model
 */

struct FileRecord {
    var fileName: String
    var files: [String]
    
    //init
    init() {
        files = [String]()
        fileName = ""
    }
    
    //get json file
    func parseJson(_ urlPaths: [URL]) -> [FileRecord] {
        var records = [FileRecord]()
        var file = FileRecord()
        for path in urlPaths {
            file.fileName = URL.getFileName(path)
            file.files = parseDataInJsonFile(path)
            records.append(file)
        }
        return records
    }
    
    //parse data in json file
    func parseDataInJsonFile(_ url: URL) -> [String] {
        guard let jsonData = try? Data(contentsOf: url, options: .mappedIfSafe) else {
            return [""]
        }
        guard let jsonResult = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) else {
            return [""]
        }
        return jsonResult as! [String]
    }
}
