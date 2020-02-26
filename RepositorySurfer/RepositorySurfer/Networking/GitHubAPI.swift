//
//  GitHubAPI.swift
//  RepositorySurfer
//
//  Created by Jeongsik Lee on 2020/02/26.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - Protocol GitHubAPI

protocol GitHubAPI {
    func fetchUsers(success: @escaping ([User]) -> Void,
                    failure: @escaping (String) -> Void)
    
    func fetchUserDetail(from user: User,
                         success: @escaping (User) -> Void,
                         failure: @escaping (String) -> Void)
    
    func fetchUserFollowers(from user: User,
                            success: @escaping ([User]) -> Void,
                            failure: @escaping (String) -> Void)
    
    func fetchUserFollowings(from user: User,
                             success: @escaping ([User]) -> Void,
                             failure: @escaping (String) -> Void)
    
    func fetchRepositories(from user: User,
                           success: @escaping ([Repository]) -> Void,
                           failure: @escaping (String) -> Void)
}

// MARK: - HTTP Request & Response

class StubbedGitHubAPI: GitHubAPI {
    
    // MARK: - API Settings
    
    private let domain = "https://api.github.com"
    
    private let headers: HTTPHeaders = [
        //FIXME: - For unlimited request,
        // 1. Please replace OAUTH-TOKEN with your own access token
        // 2. Please uncomment next line by removing the //
//        "Authorization": "token OAUTH-TOKEN",
    ]
    
    enum Endpoints {
        case fetchUsers
        case fetchUserDetail
        case fetchUserFollowers
        case fetchUserFollowings
        case fetchRepositories
    }
    
    private func getUrlString(endpoint: Endpoints, user: User? = nil) -> String? {
        switch endpoint {
        case .fetchUsers:
            return domain + "/users"
        case .fetchUserDetail:
            return user?.url
        case .fetchUserFollowers:
            return user?.followers
        case .fetchUserFollowings:
            return domain + "/users/\(user?.name ?? "")/following"
        case .fetchRepositories:
            return user?.repositories
        }
    }
    
    func fetchUsers(success: @escaping ([User]) -> Void,
                    failure: @escaping (String) -> Void) {
        guard let url = getUrlString(endpoint: .fetchUsers) else {
            failure("Networking logic error.")
            return
        }
        AF.request(url, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    failure("The data is empty.")
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode([User].self, from: data)
                    success(decodedResponse)
                } catch {
                    failure(error.localizedDescription)
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
    
    func fetchUserDetail(from user: User,
                         success: @escaping (User) -> Void,
                         failure: @escaping (String) -> Void) {
        guard let url = getUrlString(endpoint: .fetchUserDetail, user: user) else {
            failure("Networking logic error.")
            return
        }
        AF.request(url, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    failure("The data is empty.")
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode(User.self, from: data)
                    success(decodedResponse)
                } catch {
                    failure(error.localizedDescription)
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
    
    func fetchUserFollowers(from user: User,
                            success: @escaping ([User]) -> Void,
                            failure: @escaping (String) -> Void) {
        guard let url = getUrlString(endpoint: .fetchUserFollowers, user: user) else {
            failure("Networking logic error.")
            return
        }
        AF.request(url, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    failure("The data is empty.")
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode([User].self, from: data)
                    success(decodedResponse)
                } catch {
                    failure(error.localizedDescription)
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
    
    func fetchUserFollowings(from user: User,
                             success: @escaping ([User]) -> Void,
                             failure: @escaping (String) -> Void) {
        guard let url = getUrlString(endpoint: .fetchUserFollowings, user: user) else {
            failure("Networking logic error.")
            return
        }
        AF.request(url, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    failure("The data is empty.")
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode([User].self, from: data)
                    success(decodedResponse)
                } catch {
                    failure(error.localizedDescription)
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
    
    func fetchRepositories(from user: User,
                           success: @escaping ([Repository]) -> Void,
                           failure: @escaping (String) -> Void) {
        guard let url = getUrlString(endpoint: .fetchRepositories, user: user) else {
            failure("Networking logic error.")
            return
        }
        AF.request(url, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    failure("The data is empty.")
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode([Repository].self, from: data)
                    success(decodedResponse)
                } catch {
                    failure(error.localizedDescription)
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
}
