//
//  UsersReducer.swift
//  UserListApp
//
//  Created by burt on 2018. 8. 28..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import BKRedux
import RxSwift

func usersReducer(name: String, state: State?) -> (Action) -> Observable<ReducerResult> {
    return { (action) in
        guard let users = state as? [User] else { return Observable.just(ReducerResult(name: name, result: [])) }
        
        switch action {
        case is LoadUsersAction:
            return UserServiceProvider
                .loadUsers()
                .map({ (users) -> ReducerResult in
                    return ReducerResult(name: name, result: users)
                })
                .asObservable()
        case let deleteUserAction as DeleteUserAction:
            return UserServiceProvider
                .deleteUser(user: deleteUserAction.user)
                .map({ (user) -> ReducerResult in
                    var newUsers = users
                    let index = newUsers.index(where: { (userItem) -> Bool in
                        return userItem.id == user.id
                    })
                    
                    if let index = index {
                        newUsers.remove(at: index)
                    }
                    
                    return ReducerResult(name: name, result: newUsers)
                })
                .asObservable()
        case let updateUserAction as UpdateUserAction:
            return UserServiceProvider
                .updateUser(user: updateUserAction.user)
                .map({ (user: User?) -> ReducerResult in
                    guard let user = user else { return ReducerResult(name: name, result: users) }
                    
                    var newUsers = users
                    let index = newUsers.index(where: { (userItem) -> Bool in
                        return userItem.id == user.id
                    })
                    
                    if let index = index {
                        newUsers[index] = user
                    }
                    
                    return ReducerResult(name: name, result: newUsers)
                })
                .asObservable()
        case let addNewUserAction as AddNewUserAction:
            return UserServiceProvider
                .addNewUser(user: addNewUserAction.user)
                .map({ (newUser) -> ReducerResult in
                    
                    var newUsers = users
                    newUsers.insert(newUser, at: 0)
                    
                    return ReducerResult(name: name, result: newUsers)
                })
                .asObservable()
                
        default:
            break
        }
        
        return Observable.just(ReducerResult(name: name, result: []))
    }
}
