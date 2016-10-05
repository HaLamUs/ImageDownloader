//
//  DownloadViewController.swift
//  ImageDownloader
//
//  Created by Ha Lam on 10/4/16.
//  Copyright © 2016 HTKInc. All rights reserved.
//

import UIKit

class DownloadViewController: UIViewController {
    //Mark: UIControl
    @IBOutlet weak var downLoadTableView: UITableView! {
        didSet {
            let lhNib = UINib(nibName: "DownloadTableViewCell", bundle: Bundle.main)
            downLoadTableView.register(lhNib, forCellReuseIdentifier: "DownloadTableViewCell")
            downLoadTableView.delegate = self
            downLoadTableView.dataSource = self
        }
    }
    @IBOutlet weak var operationQueue: UISlider!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var pauseButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    //Mark: Varible
    var countAdd = 2
    var fileRecords:[FileRecord] = [FileRecord]() {
        didSet {
            downLoadTableView.reloadData()
        }
    }
    
    //Mark: Constaint
    let urlDropBox = "https://dl.dropboxusercontent.com/u/4529715/JSON%20files.zip"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func touchUpResetButton(_ resetButton: UIBarButtonItem) {
        print()
    }
    @IBAction func touchUpAddButton(_ addButton: UIBarButtonItem) {
        addButton.isEnabled = false
        switch countAdd {
        case 0:
            self.downLoadFileDropbox()
            countAdd += 1
        case 1:
            self.upZipFile()
            countAdd += 1
            print()
        case 2:
            self.getListFileRecord()
            countAdd += 1
            print()
        default:
            print()
        }
    }
}

extension DownloadViewController {
    func downLoadFileDropbox() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let nwCall = LHNetWork(self.urlDropBox,self)
        nwCall.downloadFile()
    }
    
    func upZipFile() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let lhManagerZip = LHManagerZip(self)
        lhManagerZip.upZipFile()
    }
    
    func getListFileRecord() {
         let zipFilePath = URL.findFileWithExtendsionAtPath(URL.getDocumentPath(), "zip").first!
        let fileName = URL.getFileName(zipFilePath)
        let pathJson = URL.getDocumentPath().appendingPathComponent(fileName + "/\(fileName)")
        let jsonFilesPath = URL.findFileWithExtendsionAtPath(pathJson, "json")
        fileRecords = FileRecord().parseJson(jsonFilesPath)
//        fileRecords = [FileRecord().parseJson(jsonFilesPath).first!]
    }
}

extension DownloadViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fileRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = downLoadTableView.dequeueReusableCell(withIdentifier: "DownloadTableViewCell", for: indexPath) as! DownloadTableViewCell
        let file = fileRecords[indexPath.row]
        cell.configCell(file)
        file.delegate = self
        if file.files.count <= 0 {
            file.parseDataInJsonFile(indexPath)
        }
        return cell
    }
}

extension DownloadViewController: LHDownloadDelegate,LHManagerZipDelegate, FileRecordDelegate {
    func downLoadDidFinish() {
        DispatchQueue.main.async {
            self.addButton.isEnabled = true
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func unZipFileDidFinish() {
        DispatchQueue.main.async {
            self.addButton.isEnabled = true
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func reloadData(_ index: IndexPath) {
        DispatchQueue.main.async {
             self.downLoadTableView.reloadRows(at: [index], with: .fade)
        }
    }

}













