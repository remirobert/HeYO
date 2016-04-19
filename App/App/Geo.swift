//
//  Geo.swift
//  App
//
//  Created by Remi Robert on 19/04/16.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit

class Geo: NSObject {

    var address: String?
    
    init?(data: [AnyObject]) {
        self.address = nil
        
        guard let geoString = data.first as? String, let dataGeo = geoString.convertToArray() else {
            return nil
        }        
        self.address = dataGeo.first as? String
    }
}
