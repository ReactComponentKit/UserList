//
//  AddNewUserAction.swift
//  UserListApp
//
//  Created by burt on 2018. 8. 29..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import ReactComponentKit

struct AddNewUserAction: Action {
    let user: User
    
    init(user: User) {
        self.user = user
    }
}
