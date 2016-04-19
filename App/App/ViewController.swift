//
//  ViewController.swift
//  App
//
//  Created by Remi Robert on 14/04/16.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SocketIOClientSwift

class ViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel = ViewControllerViewModel()
    
    @IBOutlet weak var buttonLocalisation: UIButton!
    @IBOutlet weak var buttonWeather: UIButton!
    @IBOutlet weak var buttonVenues: UIButton!
    @IBOutlet weak var buttonPhotos: UIButton!
    
    @IBOutlet weak var indicatorLocalisation: UIActivityIndicatorView!
    @IBOutlet weak var indicatorPhotos: UIActivityIndicatorView!
    @IBOutlet weak var indicatorVenues: UIActivityIndicatorView!
    @IBOutlet weak var indicatorWeather: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.buttonPhotos.enabled = false
        self.buttonVenues.enabled = false
        self.buttonWeather.enabled = false
        self.buttonLocalisation.enabled = false
        
        self.viewModel.weather.asObservable().subscribeNext { weather in
            guard let _ = weather else {
                self.buttonWeather.enabled = false
                return
            }
            self.indicatorWeather.hidden = true
            self.buttonWeather.enabled = true
        }.addDisposableTo(self.disposeBag)
        
        self.viewModel.geo.asObservable().subscribeNext { geo in
            guard let _ = geo else {
                self.buttonLocalisation.enabled = false
                return
            }
            self.indicatorLocalisation.hidden = true
            self.buttonLocalisation.enabled = true
        }.addDisposableTo(self.disposeBag)
        
        self.viewModel.photos.asObservable().subscribeNext { photos in
            guard let _ = photos else {
                self.buttonPhotos.enabled = false
                return
            }
            self.indicatorPhotos.hidden = true
            self.buttonPhotos.enabled = true
        }.addDisposableTo(self.disposeBag)

        self.viewModel.venues.asObservable().subscribeNext { venues in
            guard let _ = venues else {
                self.buttonVenues.enabled = false
                return
            }
            self.indicatorVenues.hidden = true
            self.buttonVenues.enabled = true
        }.addDisposableTo(self.disposeBag)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "weatherSegue" {
            let controller = segue.destinationViewController as! WeatherViewController
            controller.weather = self.viewModel.weather.value
        }
        else if segue.identifier == "geoSegue" {
            let controller = segue.destinationViewController as! GeoViewController
            controller.geo = self.viewModel.geo.value
        }
        else if segue.identifier == "photosSegue" {
            let controller = segue.destinationViewController as! PhotosViewController
            controller.photos = self.viewModel.photos.value
        }
        else if segue.identifier == "venuesSegue" {
            let controller = segue.destinationViewController as! VenuesViewController
            controller.venues = self.viewModel.venues.value
        }
    }
}
