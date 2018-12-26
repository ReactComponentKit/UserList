//
//  UsersReducer.swift
//  UserListApp
//
//  Created by burt on 2018. 8. 28..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import BKRedux
import RxSwift

func usersReducer(state: State, action: Action) -> Observable<State> {
    guard var mutableState = state as? UserListState else { return .just(state) }
    
    switch action {
    case is LoadUsersAction:
        return UserServiceProvider
            .loadUsers()
            .map({ (users) in
                mutableState.users = users
                return mutableState
            })
            .asObservable()
    case let deleteUserAction as DeleteUserAction:
        return UserServiceProvider
            .deleteUser(user: deleteUserAction.user)
            .map({ (user) in
                var newUsers = mutableState.users
                let index = newUsers.index(where: { (userItem) -> Bool in
                    return userItem.id == user.id
                })
                
                if let index = index {
                    newUsers.remove(at: index)
                }
                
                mutableState.users = newUsers
                return mutableState
            })
            .asObservable()
    case let updateUserAction as UpdateUserAction:
        return UserServiceProvider
            .updateUser(user: updateUserAction.user)
            .map({ (user: User?) in
                guard let user = user else { return mutableState }
                
                var newUsers = mutableState.users
                let index = newUsers.index(where: { (userItem) -> Bool in
                    return userItem.id == user.id
                })
                
                if let index = index {
                    newUsers[index] = user
                }
                mutableState.users = newUsers
                return mutableState
            })
            .asObservable()
    case let addNewUserAction as AddNewUserAction:
        return UserServiceProvider
            .addNewUser(user: addNewUserAction.user)
            .map({ (newUser) in
                
                var newUsers = mutableState.users
                newUsers.insert(newUser, at: 0)
                mutableState.users = newUsers
                return mutableState
            })
            .asObservable()
        
    default:
        break
    }
    
    return .just(mutableState)
}
