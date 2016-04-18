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
    
    var models: Variable<[DataCell?]> = Variable([])
    var weather: Variable<DataCell?> = Variable(nil)
    
    
    func performGeoRequest() {
        let request = API.Geo(lat: 31.289814, lon: 121.215573)
        Network.send(request: request).subscribeNext { (response: JSON?) in
            print("\(response)")
        }.addDisposableTo(self.disposeBag)
    }
    
    init() {
//        self.performGeoRequest()
        
        self.socket = SocketIOClient(socketURL: NSURL(string: "http://localhost:8000")!, options: [.ForcePolling(true)])
        
        self.socket.on("connect") { data, ack in
            print("socket connected")
            self.socket.emit("location", ["lat": 31.289814, "lon": 121.215573])
        }
        
        self.socket.on("geo") { data, ack in
            print("data : \(data)")
            self.weather.value = Weather(data: data) as? DataCell
        }
        self.socket.on("venues") {data, ack in
            print("data venues : \(data)")
            //            print("venues : \(data)")
        }
        self.socket.on("instagram") {data, ack in
            //            print("images : \(data)")
        }
        self.socket.on("weather") {data, ack in
            //            print("weather : \(data)")
        }
        self.socket.connect()
    }
}
