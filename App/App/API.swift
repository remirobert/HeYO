//
//  API.swift
//  App
//
//  Created by Remi Robert on 17/04/16.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit

enum API {
    case Geo(lat: Double, lon: Double)
}

extension API: NetworkRequest {

    func parameters() -> [String: AnyObject]? {
        switch self {
        case .Geo(let lat, let lon):
            return ["lat" : "\(lat)", "lon" : "\(lon)"]
        }
    }

    func path() -> String {
        let baseUrl = "http://127.0.0.1:8000"
        switch self {
        case .Geo:
            return "\(baseUrl)/geo"
        }
    }

    func method() -> NetworkMethod {
        return .POST
    }
}
