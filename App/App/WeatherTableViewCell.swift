//
//  WeatherTableViewCell.swift
//  App
//
//  Created by Remi Robert on 18/04/16.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell, Cell {

    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var temperature: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(data: DataCell) {
        print("called")
        let dataWeather = data as! Weather
        
        self.weatherDescription.text = dataWeather.descriptionWeather
        self.temperature.text = dataWeather.temp
    }
}
