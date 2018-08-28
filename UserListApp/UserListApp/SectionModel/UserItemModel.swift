//
//  UserItemModel.swift
//  UserListApp
//
//  Created by burt on 2018. 8. 29..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import ReactComponentKit

struct UserItemModel: ItemModel {
    var id: Int {
        return user.hashValue
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
