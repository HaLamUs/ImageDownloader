//
//  DownloadTableViewCell.swift
//  ImageDownloader
//
//  Created by Ha Lam on 10/5/16.
//  Copyright © 2016 HTKInc. All rights reserved.
//

import UIKit

class DownloadTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell( _ file: FileRecord) {
        self.textLabel?.text = file.fileName
        self.detailTextLabel?.text = file.fileState
    }
    
}
