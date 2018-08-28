//
//  MakeUserListSectionModel.swift
//  UserListApp
//
//  Created by burt on 2018. 8. 29..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import BKRedux
import ReactComponentKit

func makeUserListSectionModel(state: [String:State], action: Action) -> [String:State] {
    guard let userList = state["users"] as? [User] else { return state }
    
    let userItemModelList = userList.map(UserItemModel.init)
    let section = DefaultSectionModel(items: userItemModelList)
    
    var newState = state
    newState["sections"] = [section]
    return newState
}
