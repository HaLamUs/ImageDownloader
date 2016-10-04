//
//  DownloadViewController.swift
//  ImageDownloader
//
//  Created by Ha Lam on 10/4/16.
//  Copyright © 2016 HTKInc. All rights reserved.
//

import UIKit

class DownloadViewController: UIViewController {
    //Mark: Property
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func touchUpResetButton(_ resetButton: UIBarButtonItem) {
        print()
    }
    @IBAction func touchUpAddButton(_ addButton: UIBarButtonItem) {
        print()
        addButton.isEnabled = false
        self.downLoadFiles()
    }
}

extension DownloadViewController {
    func downLoadFiles(){
        let urlDropBox = "https://dl.dropboxusercontent.com/u/4529715/JSON%20files.zip"
        LHNetWork().download(urlDropBox)
//        LHNetWork.get(urlDropBox){
//            _ in
//            print()
//        }
    }
}

extension DownloadViewController:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = downLoadTableView.dequeueReusableCell(withIdentifier: "DownloadTableViewCell", for: indexPath) as! DownloadTableViewCell
        return cell
    }
}













