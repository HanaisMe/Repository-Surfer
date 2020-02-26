//
//  UserDetailInteractor.swift
//  RepositorySurfer
//
//  Created by Jeongsik Lee on 2020/02/26.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import Foundation

class UserDetailInteractor: NSObject, ViperInteractor {
    
    weak var presenter: UserDetailPresenter?
    
    func fetchUserDetail(from user: User,
                         success: @escaping (User) -> Void,
                         failure: @escaping (String) -> Void) {
        Worker().fetchUserDetail(from: user, success: { (userDetail) in
            success(userDetail)
        }, failure: { errorMessage in
            failure(errorMessage)
        })
    }
    
    func fetchUserFollowers(from user: User,
                            success: @escaping ([User]) -> Void,
                            failure: @escaping (String) -> Void) {
        Worker().fetchUserFollowers(from: user, success: { (followers) in
            success(followers)
        }, failure: { errorMessage in
            failure(errorMessage)
        })
    }
    
    func fetchUserFollowings(from user: User,
                             success: @escaping ([User]) -> Void,
                             failure: @escaping (String) -> Void) {
        Worker().fetchUserFollowings(from: user, success: { (followings) in
            success(followings)
        }, failure: { errorMessage in
            failure(errorMessage)
        })
    }
    
    func fetchRepositories(from user: User,
                           success: @escaping ([Repository]) -> Void,
                           failure: @escaping (String) -> Void) {
        Worker().fetchRepositories(from: user, success: { (repositories) in
            success(repositories)
        }, failure: { errorMessage in
            failure(errorMessage)
        })
    }
}
