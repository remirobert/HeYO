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

typealias JSON = [String: AnyObject]

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    private let disposeBag = DisposeBag()
    private let dataSource = DataSource()
    private let viewModel = ViewControllerViewModel()

    let items = Variable<[String]>([])
    
    private func bind() {
        self.tableview.dataSource = nil
        self.viewModel.models.asObservable().bindTo(self.tableview.rx_itemsWithDataSource(self.dataSource))
            .addDisposableTo(disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableview.tableFooterView = UIView()
        self.tableview.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        self.tableview.registerNib(UINib(nibName: "WeatherCollectionViewCell", bundle: nil), forCellReuseIdentifier: "weatherCell")
        
        items.value.append("One")
        items.value.append("Two")
        items.value.append("three")
        
        self.bind()
    }
}
