//
//  UserListViewModel.swift
//  UserListApp
//
//  Created by burt on 2018. 8. 28..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import RxSwift
import RxCocoa
import BKRedux
import ReactComponentKit

class UserListViewModel: RootViewModelType {
    
    let rx_sections =  BehaviorRelay<[DefaultSectionModel]>(value: [])
    
    override init() {
        super.init()
        
        store.set(
            state: [
                "users": [User]()
            ],
            reducers: [
                "users": usersReducer
            ],
            postwares: [
                logToConsole,
                makeUserListSectionModel
            ])
    }
    
    override func on(newState: [String : State]?) {
        guard let sections = newState?["sections"] as? [DefaultSectionModel] else { return }
        rx_sections.accept(sections)
    }
}
