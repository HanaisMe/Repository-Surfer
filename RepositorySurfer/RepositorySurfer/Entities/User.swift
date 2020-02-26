//
//  User.swift
//  RepositorySurfer
//
//  Created by Jeongsik Lee on 2020/02/26.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import Foundation

struct User: Codable {
    let name: String
    let icon: URL
    let url: String
    let followers: String
    let following: String
    let repositories: String
    let fullName: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case icon = "avatar_url"
        case url = "url"
        case followers = "followers_url"
        case following = "following_url"
        case repositories = "repos_url"
        case fullName = "name"
    }
}
