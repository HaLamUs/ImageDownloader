//
//  LHNetWork.swift
//  ImageDownloader
//
//  Created by Ha Lam on 10/5/16.
//  Copyright © 2016 HTKInc. All rights reserved.
//

import Foundation

enum Result{
    case success(AnyObject?)
    case failure(Error?)
}

class LHNetWork:NSObject, URLSessionDownloadDelegate {
    
    var url:URL?
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let localUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let destUrl = localUrl?.appendingPathComponent(url!.lastPathComponent)
        let dataFromUrl = try! Data(contentsOf: location)
        _ = try! dataFromUrl.write(to: destUrl!)
    }
    
    func download(_ url: String){
        let request = URL(string: url)
        self.url = request
        let config = URLSessionConfiguration.background(withIdentifier: "something")
        let session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
        let task = session.downloadTask(with: request!)
        task.resume()
    }
    
}

        
        






