//
//  UserService.swift
//  UserListApp
//
//  Created by burt on 2018. 8. 28..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import Foundation
import Moya

enum UserService {
    case create(user: User)
    case loadUsers
    case update(user: User)
    case delete(user: User)
}

extension UserService: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        switch self {
        case .loadUsers, .create(_):
            return "/users"
        case .update(let user), .delete(let user):
            return "/users/\(user.id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .create(_):
            return .post
        case .loadUsers:
            return .get
        case .update(_):
            return .put
        case .delete(_):
            return .delete
        }
    }
    
    var sampleData: Data {
        switch self {
        case .create(let user):
            return user.toJsonData
        case .loadUsers:
            return Data()
        case .update(let user):
            return user.toJsonData
        case .delete(let user):
            return "{'id':'\(user.id)'}".data(using: .utf8)!
        }
    }
    
    var task: Task {
        switch self {
        case .loadUsers, .delete(_):
            return .requestPlain
        case .create(let user), .update(let user):
            return .requestParameters(parameters: user.toParamDic,
                                      encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
}

