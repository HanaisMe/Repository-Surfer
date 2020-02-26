//
//  Worker.swift
//  RepositorySurfer
//
//  Created by Jeongsik Lee on 2020/02/26.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import Foundation

class Worker {
    
    // MARK: - API
    
    private let gitHubAPI: GitHubAPI
    
    init(gitHubAPI: GitHubAPI = StubbedGitHubAPI()) {
        self.gitHubAPI = gitHubAPI
    }
    
    // MARK: - Protocol PlaylistAPI
    
    func fetchUsers(success: @escaping ([User]) -> Void,
                    failure: @escaping (String) -> Void) {
        gitHubAPI.fetchUsers(success: { (users) in
            success(users)
        }, failure: { (errorMessage) in
            failure(errorMessage)
        })
    }
    
    func fetchUserDetail(from user: User,
                         success: @escaping (User) -> Void,
                         failure: @escaping (String) -> Void) {
        gitHubAPI.fetchUserDetail(from: user, success: { (userDetail) in
            success(userDetail)
        }, failure: { (errorMessage) in
            failure(errorMessage)
        })
    }
    
    func fetchUserFollowers(from user: User,
                            success: @escaping ([User]) -> Void,
                            failure: @escaping (String) -> Void) {
        gitHubAPI.fetchUserFollowers(from: user, success: { (followers) in
            success(followers)
        }, failure: { (errorMessage) in
            failure(errorMessage)
        })
    }
    
    func fetchUserFollowings(from user: User,
                             success: @escaping ([User]) -> Void,
                             failure: @escaping (String) -> Void) {
        gitHubAPI.fetchUserFollowings(from: user, success: { (followings) in
            success(followings)
        }, failure: { (errorMessage) in
            failure(errorMessage)
        })
    }
    
    func fetchRepositories(from user: User,
                           success: @escaping ([Repository]) -> Void,
                           failure: @escaping (String) -> Void) {
        gitHubAPI.fetchRepositories(from: user, success: { (repositories) in
            success(repositories)
        }, failure: { (errorMessage) in
            failure(errorMessage)
        })
    }
}
