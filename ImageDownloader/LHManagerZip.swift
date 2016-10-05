//
//  LHManagerZip.swift
//  ImageDownloader
//
//  Created by Ha Lam on 10/5/16.
//  Copyright © 2016 HTKInc. All rights reserved.
//

import Foundation
import Zip

/*
 This protocol for unzip file finish
 */
protocol LHManagerZipDelegate {
    func unZipFileDidFinish()
}

/*
 This struct use for unzip file
 */
struct LHManagerZip {
    //MARK: Property
    var delegate: LHManagerZipDelegate?
    
    //MARK: Function

    init(_ delegate:LHManagerZipDelegate) {
        self.delegate = delegate
    }
    
    func upZipFile() {
        let zipFilePath = URL.findFileWithExtendsionAtPath(URL.getDocumentPath(), "zip").first!
        _ = try! Zip.quickUnzipFile(zipFilePath)
        delegate?.unZipFileDidFinish()
    }
    
}



















