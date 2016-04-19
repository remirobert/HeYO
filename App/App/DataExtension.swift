//
//  DataExtension.swift
//  App
//
//  Created by Remi Robert on 15/04/16.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit

extension String {
    
    func convertToDictionary() -> JSON? {
        if let data = self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            do {
                return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
    func convertToArray() -> [AnyObject]? {
        if let data = self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            do {
                return try NSJSONSerialization.JSONObjectWithData(data,
                                                                  options: NSJSONReadingOptions.MutableContainers) as? [AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
}
