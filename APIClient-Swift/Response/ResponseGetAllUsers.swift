//
//  ResponseUserInfo.swift
//  GithubDM
//
//  Created by Eric JI on 2019/11/27.
//  Copyright © 2019 Eric JI. All rights reserved.
//

import Foundation

struct ResponseUserInfo: Codable {
    
    let login, node_id, avatar_url, gravatar_id, url, html_url, followers_url, following_url, gists_url, starred_url, subscriptions_url, organizations_url, repos_url, events_url, received_events_url, type: String?
    let id: Int?
    let site_admin: Bool
    
}
