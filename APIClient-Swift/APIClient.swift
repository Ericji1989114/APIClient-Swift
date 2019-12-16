//
//  APIClient.swift
//  APIClient-Swift
//
//  Created by Eric on 2019/12/16.
//  Copyright © 2019 eric. All rights reserved.
//

import Foundation

struct APIClient {
    
    let session: APISessionManager
    
    // MARK: - Initalize
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .useProtocolCachePolicy
        configuration.timeoutIntervalForRequest = 15.0
        configuration.timeoutIntervalForResource = 15.0
        session = APISessionManager(configuration: configuration)
    }
    
    // MARK: API List
    
    func requestGetAllUsers(completion: @escaping (APIResult<[ResponseUserInfo]>) -> Void) {
        
        let api = APIGetAllUsers()
        return session.sendRequest(api, completion: completion)
        
    }

}
