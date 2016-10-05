//
//  LHNetWork.swift
//  ImageDownloader
//
//  Created by Ha Lam on 10/5/16.
//  Copyright © 2016 HTKInc. All rights reserved.
//

import Foundation

/*
 This protocol to infor download zip file finshed
 */
protocol LHDownloadDelegate: class {
    func downLoadDidFinish()
}

/*
 This class use for download zip file
 */
class LHNetWork: NSObject {
    
    //MARK: Property
    fileprivate var url:URL?
    fileprivate weak var delegate: LHDownloadDelegate?
    
    //func: Init
    required init(_ url:String, _ delegate: LHDownloadDelegate) {
        let request = URL(string: url)
        self.url = request
        self.delegate = delegate
    }
    
    //func: Download
    func downloadFile() {
        let config = URLSessionConfiguration.background(withIdentifier: "something")
        let session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
        let task = session.downloadTask(with: url!)
        task.resume()
    }
}

extension LHNetWork: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let localUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let destUrl = localUrl?.appendingPathComponent(url!.lastPathComponent)
        let dataFromUrl = try! Data(contentsOf: location)
        _ = try! dataFromUrl.write(to: destUrl!)
        self.delegate?.downLoadDidFinish()
    }
}

        
        






