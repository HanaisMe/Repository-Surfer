//
//  UsersPresenter.swift
//  RepositorySurfer
//
//  Created by Jeongsik Lee on 2020/02/26.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import Foundation

class UsersPresenter: NSObject, ViperPresenter {
    
    typealias InteractorType = UsersInteractor
    typealias RouterType = UsersRouter
   
    weak var view: UsersViewController?
    var interactor: InteractorType?
    var router: RouterType?
    
    var users = [User]()
    
    func fetchUsers() {
        interactor?.fetchUsers(success: { [weak self] (users) in
            self?.users = users
            self?.view?.reloadData()
        }, failure: { (errorMessage) in
            // TODO: - handle error
            print(errorMessage)
        })
    }
    
    func getUsersCount() -> Int {
        return users.count
    }
    
    func getUser(at index: Int) -> User {
        return users[index]
    }
    
    func selectUser(at index: Int) {
        let selectedUser = users[index]
        router?.routeToUserDetail(with: selectedUser)
    }
}
