//
//  LogToConsole.swift
//  EmojiCollectionApp
//
//  Created by burt on 2018. 8. 26..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import BKRedux
import RxSwift

func logToConsole(state: State, action: Action) -> Observable<State> {
    print("[## LOGGING ##] action: \(String(describing: action)) :: state: \(state)")
    return .just(state)
}
