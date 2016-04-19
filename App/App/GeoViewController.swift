//
//  GeoViewController.swift
//  App
//
//  Created by Remi Robert on 19/04/16.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit

class GeoViewController: UIViewController {

    var geo: Geo!
    
    @IBOutlet weak var labelAddress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelAddress.text = self.geo.address
    }
}
