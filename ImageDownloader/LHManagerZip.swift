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
protocol LHManagerZipDelegate: class {
    func unZipFileDidFinish()
}

/*
 This class use for unzip file
 */
class LHManagerZip: NSObject {
    //MARK: Property
    weak var delegate: LHManagerZipDelegate?
    
    //MARK: Function

    required init(_ delegate:LHManagerZipDelegate) {
        self.delegate = delegate
    }
    
    func upZipFile() {
        let zipFilePath = URL.findFileWithExtendsionAtPath(URL.getDocumentPath(), "zip").first!
        _ = try! Zip.quickUnzipFile(zipFilePath)
        delegate?.unZipFileDidFinish()
    }
    
}


















