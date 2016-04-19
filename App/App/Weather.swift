//
//  Weather.swift
//  App
//
//  Created by Remi Robert on 15/04/16.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit

struct Weather: DataCell {
    
    var descriptionWeather: String?
    var temp: String?
    
    var identifier = "weather"
    
    init?(data: [AnyObject]) {
        guard let geoString = data.first as? String, let geo = geoString.convertToDictionary() else {
            return nil
        }
        self.descriptionWeather = geo["summary"] as? String
        if let temp = geo["temperature"] as? Double {
            self.temp = "\(temp)"
        }
    }
}
