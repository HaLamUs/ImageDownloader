//
//  URL+LH.swift
//  ImageDownloader
//
//  Created by Ha Lam on 10/5/16.
//  Copyright © 2016 HTKInc. All rights reserved.
//

import Foundation

/*
 This extension of URL for handle find file in documents
 */

extension URL {
    static func findFileWithExtendsionAtPath(_ path: URL, _ extendsion: String) -> [URL] {
        let contentPath = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil, options: [])
        return contentPath.filter {
            $0.pathExtension == extendsion
        }
    }
    
    static func getDocumentPath() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    static func getFileName(_ pathFile: URL) -> String {
        let sourcePath = pathFile.pathExtension
        return pathFile.lastPathComponent.replacingOccurrences(of: "." + sourcePath, with: "")
    }
}
