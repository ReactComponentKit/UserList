//
//  ButtonComponent.swift
//  EmojiCollectionApp
//
//  Created by burt on 2018. 8. 26..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import ReactComponentKit
import RxCocoa
import RxSwift

class ButtonComponent: UIViewComponent {
    
    private let disposeBag = DisposeBag()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        return button
    }()
    
    
    typealias ButtonAction = (ButtonComponent) -> Swift.Void
    var action: ButtonAction? = nil
    
    var title: String? {
        get {
            return button.title(for: [])
        }
        
        set {
            button.setTitle(newValue, for: [])
        }
    }
    
    override func setupView() {
        addSubview(button)
        button.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        button.rx.tap.subscribe(onNext: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.action?(strongSelf)
        }).disposed(by: disposeBag)
    }
    
}
