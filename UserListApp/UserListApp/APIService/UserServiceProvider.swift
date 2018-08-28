//
//  UserServiceProvider.swift
//  UserListApp
//
//  Created by burt on 2018. 8. 28..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import Moya
import RxSwift
import RxCocoa

enum UserServiceProvider {
    static private let provider = MoyaProvider<UserService>()
    
    static func loadUsers() -> Single<[User]> {
        return Single.create(subscribe: { (single) -> Disposable in
            
            let cancellable = provider.request(.loadUsers) { (result) in
                switch result {
                case let .success(response):
                    let users = try? response.map([User].self)
                    single(.success(users ?? []))
                case let .failure(error):
                    single(.error(error))
                }
            }
            
            return Disposables.create {
                if cancellable.isCancelled == false {
                    cancellable.cancel()
                }
            }
        })
    }
    
    static func deleteUser(user: User) -> Single<User> {
        return Single.create(subscribe: { (single) -> Disposable in
            let cancellable = provider.request(.delete(user: user)) { (result) in
                switch result {
                case .success(_):
                    single(.success(user))
                case let .failure(error):
                    single(.error(error))
                }
            }
            
            return Disposables.create {
                if cancellable.isCancelled == false {
                    cancellable.cancel()
                }
            }
        })
    }
    
    static func updateUser(user: User) -> Single<User?> {
        return Single.create(subscribe: { (single) -> Disposable in
            
            let newUser = User(id: user.id, name: "\(user.name)😋", username: user.username,
                               email: user.email,
                               phone: user.phone)
            
            let cancellable = provider.request(.update(user: newUser)) { (result) in
                switch result {
                case let .success(response):
                    let updatedUser = try? response.map(User.self)
                    single(.success(updatedUser))
                case let .failure(error):
                    single(.error(error))
                }
            }
            
            return Disposables.create {
                if cancellable.isCancelled == false {
                    cancellable.cancel()
                }
            }
        })
    }
    
}
