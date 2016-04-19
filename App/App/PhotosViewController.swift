//
//  PhotosViewController.swift
//  App
//
//  Created by Remi Robert on 19/04/16.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    var photos: [Photos]!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionLayout.itemSize = CGSizeMake(CGRectGetWidth(UIScreen.mainScreen().bounds) / 3, CGRectGetWidth(UIScreen.mainScreen().bounds) / 3)
        self.collectionLayout.scrollDirection = .Vertical
        self.collectionLayout.minimumLineSpacing = 0
        self.collectionLayout.minimumInteritemSpacing = 0
        
        self.collectionView.registerNib(UINib(nibName: "PhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor.whiteColor()
    }
}

extension PhotosViewController: UICollectionViewDataSource {

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! PhotosCollectionViewCell
        
        if let url = self.photos[indexPath.row].url {
            cell.configure(url)
        }
        return cell
    }    
}
