//
//  UserDetailPresenter.swift
//  RepositorySurfer
//
//  Created by Jeongsik Lee on 2020/02/26.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import Foundation

class UserDetailPresenter: NSObject, ViperPresenter {
    
    typealias InteractorType = UserDetailInteractor
    typealias RouterType = UserDetailRouter
   
    weak var view: UserDetailViewController?
    var interactor: InteractorType?
    var router: RouterType?
    
    // MARK: - User
    
    private var user: User?
    
    convenience init(with user: User) {
        self.init()
        self.user = user
    }
    
    func fetchBasicUserInfo() {
        guard let user = user else { return }
        view?.setBasicUserInfo(user)
    }
    
    // MARK: - User Details
    
    private var fetchUserDetailStatus = false
    private var fetchUserFollowersStatus = false
    private var fetchUserFollowingsStatus = false
    
    private func initFetchUserInfoStatus() {
        fetchUserDetailStatus = false
        fetchUserFollowersStatus = false
        fetchUserFollowingsStatus = false
    }
    
    private func checkFetchUserInfoStatus() {
        if fetchUserDetailStatus, fetchUserFollowersStatus, fetchUserFollowingsStatus {
            view?.showUserInfoViewWithAnimation()
        }
    }
    
    func fetchDetailedUserInfo() {
        guard let user = user else { return }
        initFetchUserInfoStatus()
        fetchUserDetail(user)
        fetchUserFollowers(user)
        fetchUserFollowings(user)
        fetchUserRepositories(user)
    }
    
    private func fetchUserDetail(_ user: User) {
        interactor?.fetchUserDetail(from: user, success: { [weak self] (userDetail) in
            self?.fetchUserDetailStatus = true
            self?.user = userDetail // refresh data
            self?.view?.setDetailedUserInfo(fullName: userDetail.fullName)
            self?.checkFetchUserInfoStatus()
        }, failure: { errorMessage in
            // TODO: - handle error
            print(errorMessage)
        })
    }
    
    private func fetchUserFollowers(_ user: User) {
        interactor?.fetchUserFollowers(from: user, success: { [weak self] (followers) in
            self?.fetchUserFollowersStatus = true
            self?.view?.setDetailedUserInfo(followersCount: followers.count)
            self?.checkFetchUserInfoStatus()
        }, failure: { errorMessage in
            // TODO: - handle error
            print(errorMessage)
        })
    }
    
    private func fetchUserFollowings(_ user: User) {
        interactor?.fetchUserFollowings(from: user, success: {[weak self] (followings) in
            self?.fetchUserFollowingsStatus = true
            self?.view?.setDetailedUserInfo(followingsCount: followings.count)
            self?.checkFetchUserInfoStatus()
        }, failure: { errorMessage in
            // TODO: - handle error
            print(errorMessage)
        })
    }
    
    // MARK: - User Repositories
        
    private var repositories = [Repository]()
    
    private func fetchUserRepositories(_ user: User) {
        interactor?.fetchRepositories(from: user, success: { [weak self] (repositories) in
            self?.repositories = repositories
            self?.view?.reloadUserRepositories()
            self?.checkFetchUserInfoStatus()
        }, failure: { errorMessage in
            // TODO: - handle error
            print(errorMessage)
        })
    }
    
    func getRepositoriesCount() -> Int {
        return repositories.count
    }
    
    func getRepository(at index: Int) -> Repository {
        return repositories[index]
    }
    
    func selectRepository(at index: Int) {
        let selectedRepository = repositories[index]
        router?.routeToRepository(with: selectedRepository)
    }
}
