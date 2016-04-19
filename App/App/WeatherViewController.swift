//
//  WeatherViewController.swift
//  App
//
//  Created by Remi Robert on 19/04/16.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    var weather: Weather!
    
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelTemp.text = self.weather.temp
        self.labelDescription.text = self.weather.descriptionWeather
    }
}
