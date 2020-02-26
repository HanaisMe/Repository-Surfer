//
//  UserDetailRouter.swift
//  RepositorySurfer
//
//  Created by Jeongsik Lee on 2020/02/26.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import Foundation

class UserDetailRouter: ViperRouter {
    
    weak var view: UserDetailViewController?
    
    func routeToRepository(with repository: Repository) {
        let repositoryVC = Builder.buildRepositoryModule(with: repository)
        view?.navigationController?.pushViewController(repositoryVC, animated: true)
    }
}
