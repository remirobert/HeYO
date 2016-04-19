//
//  Photos.swift
//  App
//
//  Created by Remi Robert on 19/04/16.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit

class Photos {
    
    var url: String?

    init?(data: JSON) {
        guard let images = data["images"] as? JSON, let lowResolution = images["low_resolution"] as? JSON,
            let url = lowResolution["url"] as? String else {
            return nil
        }
        self.url = url
    }
    
    class func initPhotos(data: [AnyObject]) -> [Photos] {
        guard let stringData = data.first as? String, let jsonData = stringData.convertToArray() else {
            return []
        }

        var tab = Array<Photos>()
        for currentImage in jsonData {
            if let image =  Photos(data: currentImage as! JSON) {
                tab.append(image)
            }
        }
        return tab
    }
}
