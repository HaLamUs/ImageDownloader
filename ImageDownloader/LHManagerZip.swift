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
 This struct use for unzip file
 */
class LHManagerZip: NSObject {
    //MARK: Property
    weak var delegate: LHManagerZipDelegate?
    
    //MARK: Function
    
    required init(_ delegate:LHManagerZipDelegate) {
        self.delegate = delegate
    }
    
    func upZipFile() {
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let contentPath = try! FileManager.default.contentsOfDirectory(at: documentPath, includingPropertiesForKeys: nil, options: [])
        let zipFile = contentPath.filter{
            $0.pathExtension == "zip"
        }
        _ = try! Zip.quickUnzipFile(zipFile.first!)
        delegate?.unZipFileDidFinish()
        print("Unzip Xong roi nhe")
    }
}
