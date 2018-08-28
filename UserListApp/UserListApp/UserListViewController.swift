//
//  ViewController.swift
//  UserListApp
//
//  Created by burt on 2018. 8. 28..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import ReactComponentKit

class UserListViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel = UserListViewModel()
    
    private lazy var adapter: UITableViewAdapter = {
        let adapter = UITableViewAdapter(tableViewComponent: self.tableViewComponent, useDiff: true)
        return adapter
    }()
    
    private lazy var tableViewComponent: UITableViewComponent = {
        let component = UITableViewComponent(token: self.viewModel.token, canOnlyDispatchAction: true)
        return component
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableViewComponent)
        tableViewComponent.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        setupTableViewComponent()
        
        viewModel.rx_sections.asDriver()
            .drive(onNext: { [weak self] (sections) in
                guard let strongSelf = self else { return }
                strongSelf.adapter.set(sections: sections)
            })
            .disposed(by: disposeBag)
        
        tableViewComponent.dispatch(action: LoadUsersAction())
    }
}

extension UserListViewController {
    fileprivate func setupTableViewComponent() {
        tableViewComponent.register(component: UserCardComponent.self)
        tableViewComponent.adapter = adapter
    }
}

