//
//  Weather.swift
//  App
//
//  Created by Remi Robert on 15/04/16.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit

class Weather: DataCell {
    
    var descriptionWeather: String?
    var temp: String?
    
    var identifier = "weather"
    
    init?(data: [AnyObject]) {
        guard let geoString = data.first as? String, let geo = geoString.convertToArray() else {
            return nil
        }
        self.descriptionWeather = geo[0] as? String
        self.temp = geo[1] as? String        
    }
}
