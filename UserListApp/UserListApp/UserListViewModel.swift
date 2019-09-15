//
//  UserListViewModel.swift
//  UserListApp
//
//  Created by burt on 2018. 8. 28..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import RxSwift
import RxCocoa
import ReactComponentKit
import Fakery

enum ViewState {
    case none
    case loading
    case requesting
    case list
    case error
}

struct UserListState: State {
    var viewState: ViewState = .none
    var users: [User] = []
    var sections: [DefaultSectionModel] = []
    var error: RCKError? = nil
}

class UserListViewModel: RCKViewModel<UserListState> {
    
    let viewState = Output<ViewState>(value: .loading)
    let sections =  Output<[DefaultSectionModel]>(value: [])
    
    override func setupStore() {
        initStore { store in
            store.initial(state: UserListState())
            store.beforeActionFlow(logAction)
            
            store.flow(action: LoadUsersAction.self)
                .flow(
                    awaitFlow(loadUsers),
                    { state, _ in makeCollectionViewSectionModels(state: state) }
                )
            
            store.flow(action: AddNewUserAction.self)
                .flow(
                    awaitFlow(addNewUser),
                    { state, _ in makeCollectionViewSectionModels(state: state) }
                )
            
            store.flow(action: DeleteUserAction.self)
                .flow(
                    awaitFlow(deleteUser),
                    { state, _ in makeCollectionViewSectionModels(state: state) }
                )
            
            store.flow(action: UpdateUserAction.self)
                .flow(
                    awaitFlow(updateUser),
                    { state, _ in makeCollectionViewSectionModels(state: state) }
                )
        }
    }
        
    override func on(newState: UserListState) {
        sections.accept(newState.sections)
        viewState.accept(.list)
    }
    
    override func on(error: RCKError) {
        viewState.accept(.error)
    }
    
    
    func newUser() -> User {
        return withState { state in
            let id = state.users.count + 1
            let name = "\(Faker().name.firstName()) \(Faker().name.lastName())"
            let username = Faker().name.name()
            let email = Faker().internet.email()
            let phone = Faker().phoneNumber.phoneNumber()
            return User(id: id, name: name, username: username, email: email, phone: phone)
        }
    }
}
