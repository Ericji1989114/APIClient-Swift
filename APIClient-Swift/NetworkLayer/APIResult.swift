//
//  APIResult.swift
//  GithubDM
//
//  Created by Eric JI on 2019/11/27.
//  Copyright © 2019 Eric JI. All rights reserved.
//

import Foundation

public enum APIResult<Value> {
    
    case success(Value)
    case failure(APIError)
    
}
