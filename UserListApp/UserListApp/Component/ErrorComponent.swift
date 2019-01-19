//
//  ErrorComponent.swift
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
import FontAwesome_swift

class ErrorComponent: UIViewControllerComponent {
    
    private let disposeBag = DisposeBag()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.fontAwesome(ofSize: 100, style: .solid)
        label.text = String.fontAwesomeIcon(name: .grinBeamSweat)
        return label
    }()
    
    
    private lazy var loadingButton: ButtonComponent = {
        let button = ButtonComponent(token: self.token, receiveState: false)
        button.title = "RELOADING"
        button.layer.cornerRadius = 8
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(errorLabel)
        view.addSubview(loadingButton)
        
        errorLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        loadingButton.snp.makeConstraints { (make) in
            make.top.equalTo(errorLabel.snp.bottom).offset(16)
            make.width.equalTo(120)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
        }
        
        loadingButton.action = { (sender) in
            sender.dispatch(action: LoadUsersAction())
        }
    }
}
