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
import Fakery

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
    
    func newUser() -> User {
        var id: Int = 0
        if let users = store.state["users"] as? [User] {
            id = users.count + 1
        }
        
        let name = "\(Faker().name.firstName()) \(Faker().name.lastName())"
        let username = Faker().name.name()
        let email = Faker().internet.email()
        let phone = Faker().phoneNumber.phoneNumber()
        return User(id: id, name: name, username: username, email: email, phone: phone)
    }
}
