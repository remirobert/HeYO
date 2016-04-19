//
//  ViewControllerViewModel.swift
//  App
//
//  Created by Remi Robert on 15/04/16.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit
import RxSwift
import SocketIOClientSwift

class ViewControllerViewModel {

    private var socket: SocketIOClient
    private let disposeBag = DisposeBag()
    
    var weather: Variable<Weather?> = Variable(nil)
    var geo: Variable<Geo?> = Variable(nil)
    var photos: Variable<[Photos]?> = Variable(nil)
    var venues: Variable<[Venue]?> = Variable(nil)
    
    init() {
//        self.performGeoRequest()
        
        self.socket = SocketIOClient(socketURL: NSURL(string: "http://localhost:8000")!, options: [.ForcePolling(true)])
        
        self.socket.on("connect") { data, ack in
            print("socket connected")
            self.socket.emit("location", ["lat": 31.289814, "lon": 121.215573])
        }
        
        self.socket.on("geo") { data, ack in
            self.geo.value = Geo(data: data)
        }
        self.socket.on("venues") {data, ack in
            print("data venues : \(data)")
            self.venues.value = Venue.initPhotos(data)
            //            print("venues : \(data)")
        }
        self.socket.on("instagram") {data, ack in
            self.photos.value = Photos.initPhotos(data)
        }
        self.socket.on("weather") {data, ack in
            self.weather.value = Weather(data: data)
        }
        self.socket.connect()
    }
}
