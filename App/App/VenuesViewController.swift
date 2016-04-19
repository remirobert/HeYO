//
//  VenuesViewController.swift
//  App
//
//  Created by Remi Robert on 19/04/16.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit

class VenuesViewController: UIViewController {

    var venues: [Venue]!
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableview.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableview.dataSource = self
    }
}

extension VenuesViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.venues.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        
        cell?.textLabel?.text = self.venues[indexPath.row].name
        return cell!
    }
}
