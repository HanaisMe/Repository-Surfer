//
//  UsersInteractor.swift
//  RepositorySurfer
//
//  Created by Jeongsik Lee on 2020/02/26.ß
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import Foundation

class UsersInteractor: NSObject, ViperInteractor {
    
    weak var presenter: UsersPresenter?
    
    func fetchUsers(success: @escaping ([User]) -> Void,
                    failure: @escaping (String) -> Void) {
        Worker().fetchUsers(success: { (users) in
            success(users)
        }, failure: { errorMessage in
            failure(errorMessage)
        })
    }
}
