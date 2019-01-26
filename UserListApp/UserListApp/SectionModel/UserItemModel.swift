//
//  UserItemModel.swift
//  UserListApp
//
//  Created by burt on 2018. 8. 29..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import ReactComponentKit

struct UserItemModel: ItemModel, Hashable, Equatable {
    
    static func == (lhs: UserItemModel, rhs: UserItemModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    var id: Int {
        return self.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(user.id)
        hasher.combine(user.name)
        hasher.combine(user.email)
        hasher.combine(user.username)
        hasher.combine(user.phone)
    }
    
    var componentClass: UIViewComponent.Type {
        return UserCardComponent.self
    }
    
    var contentSize: CGSize {
        // Use Components ContentSize
        // Currently, only support UITableViewComponent's cell
        return CGSize.zero
    }
    
    let user: User
    init(user: User) {
        self.user = user
    }
}
