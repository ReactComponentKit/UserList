//
//  TableViewComponent.swift
//  ReactComponentKitApp
//
//  Created by burt on 2018. 8. 12..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import UIKit
import SnapKit

import BKRedux
import BKEventBus

import RxSwift
import RxCocoa

open class UITableViewComponent: UIViewComponent {
    
    public var headerComponent: UIViewComponent? {
        get {
            return tableView.tableHeaderView as? UIViewComponent
        }
        
        set {
            tableView.tableHeaderView = newValue
        }
    }
    
    public var footerComponent: UIViewComponent? {
        get {
            return tableView.tableFooterView as? UIViewComponent
        }
        
        set {
            tableView.tableFooterView = newValue
        }
    }
    
    public var adapter: UITableViewAdapter? {
        didSet {
            tableView.delegate = adapter
            tableView.dataSource = adapter
            tableView.reloadData()
        }
    }
    
    public var seperatorInset: UIEdgeInsets {
        get {
            return tableView.separatorInset
        }
        
        set {
            tableView.separatorInset = newValue
        }
    }
    
    public var contentInset: UIEdgeInsets {
        get {
            return tableView.contentInset
        }
        
        set {
            tableView.contentInset = newValue
        }
    }
    
    public var seperatorColor: UIColor? {
        get {
            return tableView.separatorColor
        }
        
        set {
            tableView.separatorColor = newValue
        }
    }
    
    private let disposeBag = DisposeBag()
    private(set) var tableView: UITableView
    public required init(token: Token) {
        self.tableView = UITableView(frame: .zero, style: .plain)
        super.init(token: token)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public required init(token: Token, canOnlyDispatchAction: Bool) {
        fatalError("init(token:canOnlyDispatchAction:) has not been implemented")
    }
    
    open override func setupView() {
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        tableView.backgroundColor = .clear
        tableView.separatorInset = .zero
        tableView.contentInset = .zero
        tableView.separatorColor = UIColor.clear
        // Performance is not good.
        // tableView.rowHeight = UITableViewAutomaticDimension
        // tableView.estimatedRowHeight = 1
    }
    
    public func register<UIViewComponentType: UIViewComponent>(component: UIViewComponentType.Type) {
        let cellClass = TableViewComponentCell.self
        self.tableView.register(cellClass, forCellReuseIdentifier: String(describing: component))
    }
    
    open func reloadData() {
        self.tableView.reloadData()
    }
    
}
