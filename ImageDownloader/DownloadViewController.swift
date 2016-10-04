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
    var countAdd = 0
    
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
            self.downLoadFiles()
            countAdd += 1
        case 1:
            self.upZipFile()
            countAdd += 1
            print()
        case 2:
            countAdd += 1
            print()
        default:
            print()
        }
    }
}

extension DownloadViewController {
    func downLoadFiles(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let urlDropBox = "https://dl.dropboxusercontent.com/u/4529715/JSON%20files.zip"
        let nwCall = LHNetWork(urlDropBox,self)
        nwCall.downloadDropBox()
    }
    
    func upZipFile(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let lhManagerZip = LHManagerZip(self)
        lhManagerZip.upZipFile()
    }
}

extension DownloadViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = downLoadTableView.dequeueReusableCell(withIdentifier: "DownloadTableViewCell", for: indexPath) as! DownloadTableViewCell
        return cell
    }
}

extension DownloadViewController: LHDownloadDelegate,LHManagerZipDelegate {
    func downLoadDidFinish() {
        DispatchQueue.main.async {
            self.addButton.isEnabled = true
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func unZipFileDidFinish() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        print()
    }

}













