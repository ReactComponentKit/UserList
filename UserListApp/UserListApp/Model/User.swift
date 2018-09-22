//
//  User.swift
//  UserListApp
//
//  Created by burt on 2018. 8. 28..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import Foundation

struct User: Codable, Hashable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    
    public var hashValue: Int {
        return name.hashValue
    }
}

extension User {
    var toJsonData: Data {
        guard let jsonData = try? JSONEncoder().encode(self) else { return "{}".data(using: .utf8)! }
        return jsonData
    }
    
    var toParamDic: [String:String] {
        return [
            "id": "\(id)",
            "name": name,
            "username": username,
            "email": email,
            "phone": phone
        ]
    }
}
