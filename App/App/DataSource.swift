//
//  DataSource.swift
//  App
//
//  Created by Remi Robert on 15/04/16.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol DataCell {
    var identifier: String { get }
}

protocol Cell {
    func configure(data: DataCell)
}

class DataSource: NSObject, UITableViewDataSource {
    
    var items: [DataCell?]?
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("return coun item : \(items?.count ?? 0)")
        return items?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let item = items![indexPath.row],
            let cell = tableView.dequeueReusableCellWithIdentifier(item.identifier, forIndexPath: indexPath) as? Cell else {
            return UITableViewCell()
        }
        cell.configure(item)
        return cell as! UITableViewCell
    }
}
