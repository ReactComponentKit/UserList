//
//  UsersReducer.swift
//  UserListApp
//
//  Created by burt on 2018. 8. 28..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import BKRedux
import RxSwift

func usersReducer<S>(name: StateKeyPath<S>, state: StateValue?) -> (Action) -> Observable<(StateKeyPath<S>, StateValue?)> {
    return { (action) in
        guard let users = state as? [User] else { return .just((name, [])) }
        
        switch action {
        case is LoadUsersAction:
            return UserServiceProvider
                .loadUsers()
                .map({ (users) in
                    return (name, users)
                })
                .asObservable()
        case let deleteUserAction as DeleteUserAction:
            return UserServiceProvider
                .deleteUser(user: deleteUserAction.user)
                .map({ (user) in
                    var newUsers = users
                    let index = newUsers.index(where: { (userItem) -> Bool in
                        return userItem.id == user.id
                    })
                    
                    if let index = index {
                        newUsers.remove(at: index)
                    }
                    
                    return (name, newUsers)
                })
                .asObservable()
        case let updateUserAction as UpdateUserAction:
            return UserServiceProvider
                .updateUser(user: updateUserAction.user)
                .map({ (user: User?) in
                    guard let user = user else { return (name, users) }
                    
                    var newUsers = users
                    let index = newUsers.index(where: { (userItem) -> Bool in
                        return userItem.id == user.id
                    })
                    
                    if let index = index {
                        newUsers[index] = user
                    }
                    
                    return (name, newUsers)
                })
                .asObservable()
        case let addNewUserAction as AddNewUserAction:
            return UserServiceProvider
                .addNewUser(user: addNewUserAction.user)
                .map({ (newUser) in
                    
                    var newUsers = users
                    newUsers.insert(newUser, at: 0)
                    
                    return (name, newUsers)
                })
                .asObservable()
                
        default:
            break
        }
        
        return .just((name, []))
    }
}
