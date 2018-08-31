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

enum ViewState {
    case loading
    case requesting
    case list
    case error
}

class UserListViewModel: RootViewModelType {
    
    let rx_viewState = BehaviorRelay<ViewState>(value: .loading)
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
    
    override func beforeDispatch(action: Action) {
        switch action {
        case is LoadUsersAction:
            rx_viewState.accept(.loading)
        case is AddNewUserAction, is DeleteUserAction, is UpdateUserAction:
            rx_viewState.accept(.requesting)
        default:
            break
        }
    }
    
    override func on(newState: [String : State]?) {
        if let sections = newState?["sections"] as? [DefaultSectionModel] {
            rx_sections.accept(sections)
        }
        rx_viewState.accept(.list)
    }
    
    override func on(error: Error, action: Action) {
        rx_viewState.accept(.error)
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
