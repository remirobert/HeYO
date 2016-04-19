//
//  PhotosCollectionViewCell.swift
//  App
//
//  Created by Remi Robert on 19/04/16.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit
import PINRemoteImage

class PhotosCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imagePhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.blackColor()
        self.imagePhoto.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        self.imagePhoto = nil
    }
    
    func configure(url: String) {
        if let url = NSURL(string: url) {
            self.imagePhoto.pin_setImageFromURL(url)
        }
    }
}
