//
//  MakeUserListSectionModel.swift
//  UserListApp
//
//  Created by burt on 2018. 8. 29..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import RxSwift
import BKRedux
import ReactComponentKit

func makeUserListSectionModel(state: State, action: Action) -> Observable<(State)> {
    guard let userListState = state as? UserListState else { return .just(state) }
    
    let userItemModelList = userListState.users.map(UserItemModel.init)
    let section = DefaultSectionModel(items: userItemModelList)
    
    var newState = userListState
    newState.sections = [section]
    
    newState.sections.forEach { (sectionModel) in
        sectionModel.items.forEach({ (item) in
            print("[## item \(item)")
        })
    }
    return .just(newState)
}
