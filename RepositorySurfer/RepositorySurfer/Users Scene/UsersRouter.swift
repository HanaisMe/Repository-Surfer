//
//  UsersRouter.swift
//  RepositorySurfer
//
//  Created by Jeongsik Lee on 2020/02/26.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import Foundation

class UsersRouter: ViperRouter {
    
    weak var view: UsersViewController?
    
    func routeToUserDetail(with user: User) {
        let userDetailVC = Builder.buildUserDetailScene(with: user)
        view?.navigationController?.pushViewController(userDetailVC, animated: true)
    }
}
