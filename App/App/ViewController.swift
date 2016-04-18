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

    @IBOutlet weak var tableview: UITableView!
    
    private let dataSource = DataSource()
    
    private let disposeBag = DisposeBag()
//    private let viewModel = ViewControllerViewModel()

    let items = Variable<[String]>([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tableview.tableFooterView = UIView()
//        self.tableview.registerNib(UINib(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "weather")
//        
//        self.dataSource.items = []
//        self.tableview.dataSource = self.dataSource
//
//        self.viewModel.weather.asObservable().subscribeNext { (data: DataCell?) in
//            print("reload data")
//            self.dataSource.items = [data]
//            self.tableview.reloadData() 
//        }.addDisposableTo(self.disposeBag)
    }
}
