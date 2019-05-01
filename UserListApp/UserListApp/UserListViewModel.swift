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

struct UserListState: State {
    var users: [User] = []
    var sections: [DefaultSectionModel] = []
    var error: (Error, Action)? = nil
}

class UserListViewModel: RootViewModelType<UserListState> {
    
    let viewState = Output<ViewState>(value: .loading)
    let sections =  Output<[DefaultSectionModel]>(value: [])
    
    override init() {
        super.init()
        
        store.set(
            initialState: UserListState(),
            reducers: [
                usersReducer,
                makeUserListSectionModel,
                logToConsole
            ])
    }
    
    override func beforeDispatch(action: Action) -> Action {
        switch action {
        case is LoadUsersAction:
            viewState.accept(.loading)
        case is AddNewUserAction, is DeleteUserAction, is UpdateUserAction:
            viewState.accept(.requesting)
        default:
            break
        }
        return action
    }
    
    override func on(newState: UserListState) {
        sections.accept(newState.sections)
        viewState.accept(.list)
    }
    
    override func on(error: Error, action: Action) {
        viewState.accept(.error)
    }
    
    
    func newUser() -> User {
        let id = store.state.users.count + 1
        let name = "\(Faker().name.firstName()) \(Faker().name.lastName())"
        let username = Faker().name.name()
        let email = Faker().internet.email()
        let phone = Faker().phoneNumber.phoneNumber()
        return User(id: id, name: name, username: username, email: email, phone: phone)
    }
}
