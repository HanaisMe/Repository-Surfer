//
//  Repository.swift
//  RepositorySurfer
//
//  Created by Jeongsik Lee on 2020/02/26.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import Foundation

struct Repository: Codable {
    let name: String
    let url: URL
    let description: String?
    let fork: Bool
    let starCount: Int
    let language: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case url = "html_url"
        case description = "description"
        case fork = "fork"
        case starCount = "stargazers_count"
        case language = "language"
    }
}
