//
//  UsersReducer.swift
//  UserListApp
//
//  Created by burt on 2018. 8. 28..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import ReactComponentKit
import RxSwift

extension UserListViewModel {
    
    func loadUsers(action: LoadUsersAction) -> Observable<UserListState> {
        
        setState {
            $0.copy { $0.viewState = .loading }
        }
        
        return UserServiceProvider
            .loadUsers()
            .map({ [weak self] (users) in
                guard let strongSelf = self else { return UserListState() }
                return strongSelf.withState { state in
                    state.copy { $0.users = users }
                }
            })
            .asObservable()
    }
    
    func deleteUser(action: DeleteUserAction) -> Observable<UserListState> {
        
        setState {
            $0.copy { $0.viewState = .requesting }
        }
        
        return UserServiceProvider
            .deleteUser(user: action.user)
            .map({ [weak self] (user) in
                guard let strongSelf = self else { return UserListState() }
                return strongSelf.withState { state in
                    var newUsers = state.users
                    let index = newUsers.index(where: { (userItem) -> Bool in
                        return userItem.id == user.id
                    })
                    
                    if let index = index {
                        newUsers.remove(at: index)
                    }
                    
                    return state.copy { $0.users = newUsers }
                }
            })
            .asObservable()
    }
    
    func updateUser(action: UpdateUserAction) -> Observable<UserListState> {
        
        setState {
            $0.copy { $0.viewState = .requesting }
        }
        
        return UserServiceProvider
            .updateUser(user: action.user)
            .map({ [weak self] (user: User?) in
                guard let strongSelf = self else { return UserListState() }
                return strongSelf.withState { state in
                    guard let user = user else { return state }
                    var newUsers = state.users
                    
                    let index = newUsers.index(where: { (userItem) -> Bool in
                        return userItem.id == user.id
                    })
                    
                    if let index = index {
                        newUsers[index] = user
                    }
                    return state.copy { $0.users = newUsers }
                }
            })
            .asObservable()
    }
    
    func addNewUser(action: AddNewUserAction) -> Observable<UserListState> {
        
        setState {
            $0.copy { $0.viewState = .requesting }
        }
        
        return UserServiceProvider
            .addNewUser(user: action.user)
            .map({ [weak self] (newUser) in
                guard let strongSelf = self else { return UserListState() }
                return strongSelf.withState { state in
                    var newUsers = state.users
                    newUsers.insert(newUser, at: 0)
                    return state.copy { $0.users = newUsers }
                }
            })
            .asObservable()
    }
}
