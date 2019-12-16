//
//  APIGetAllUsers.swift
//  GithubDM
//
//  Created by Eric JI on 2019/11/27.
//  Copyright © 2019 Eric JI. All rights reserved.
//

import Foundation

struct APIGetAllUsers: APIProtocol {    
    
    typealias ResponseType = [ResponseUserInfo]

    let method: HTTPMethod = .get
    let apiPath: String = "users"
    let baseUrl = URL(string: "https://api.github.com")
    let parameters: Parameters? = ["since": "135"]
    
}

extension APIGetAllUsers: CustomDebugStringConvertible {
    
    var debugDescription: String {
        let method = self.method
        let requestUrl = self.getAPIRequstUrl()
        let param = self.parameters
        let headers = self.headers
        
        return "🧐Request Url: \(String(describing: requestUrl))\n🧐Http method: \(method)\n🧐Parameters: \(String(describing: param))\n🧐Http headers: \(String(describing: headers))\n"
    }
    
}
