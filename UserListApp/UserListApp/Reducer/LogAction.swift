//
//  LogToConsole.swift
//  EmojiCollectionApp
//
//  Created by burt on 2018. 8. 26..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import ReactComponentKit

func logAction(action: Action) -> Action {
    print("[## LOGGING ##] action: \(action)")
    return action
}
