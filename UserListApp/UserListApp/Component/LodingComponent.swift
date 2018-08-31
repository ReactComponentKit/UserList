//
//  LodingComponent.swift
//  UserListApp
//
//  Created by burt on 2018. 8. 28..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import UIKit
import SnapKit
import ReactComponentKit
import MaterialActivityIndicator

class LoadingComponent: UIViewControllerComponent {
    private lazy var indicator: MaterialActivityIndicatorView = {
        let view = MaterialActivityIndicatorView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(indicator)
        indicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        indicator.startAnimating()
    }
}
