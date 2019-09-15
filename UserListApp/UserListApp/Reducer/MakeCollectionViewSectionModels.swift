//
//  MakeUserListSectionModel.swift
//  UserListApp
//
//  Created by burt on 2018. 8. 29..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import RxSwift
import ReactComponentKit

func makeCollectionViewSectionModels(state: UserListState) -> UserListState {
    let userItemModelList = state.users.map(UserItemModel.init)
    let section = DefaultSectionModel(items: userItemModelList)
    
    return state.copy {
        $0.sections = [section]
    }
}
