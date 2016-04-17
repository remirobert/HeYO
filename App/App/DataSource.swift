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

class DataSource: NSObject, RxTableViewDataSourceType, UITableViewDataSource {

    typealias Element = [DataCell]
    
    var items: Element?
    
    func tableView(tableView: UITableView, observedEvent: RxSwift.Event<Element>) {
        switch observedEvent {
        case .Next(let value):
            self.items = value
            
            tableView.reloadData()
            
        case .Error(let error):
            print("Error: \(error)")
            
        case .Completed:
            print("Completed")
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? Cell else {
            return UITableViewCell()
        }
        cell.configure(items![indexPath.row])
        return cell as! UITableViewCell
    }
}
