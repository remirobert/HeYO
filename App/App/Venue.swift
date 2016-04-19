//
//  Venue.swift
//  App
//
//  Created by Remi Robert on 18/04/16.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit

class Venue {

    var name: String?
    var categorie: String?
    var picture: String?
    
    init?(data: JSON) {
        guard let venue = data["venue"] as? JSON, let name = venue["name"] as? String else {
            return nil
        }
        
//        guard let categorie = venue["categories"] as? [JSON], let nameCat = categorie.first!["name"] as? String else {
//            return nil
//        }
        self.name = name
//        self.categorie = nameCat
    }
    
    class func initPhotos(data: [AnyObject]) -> [Venue] {
        guard let stringData = data.first as? String, let jsonData = stringData.convertToArray() else {
            return []
        }
        
        var tab = Array<Venue>()
        for currentVenue in jsonData {
            if let venue =  Venue(data: currentVenue as! JSON) {
                tab.append(venue)
            }
        }
        return tab
    }
}
