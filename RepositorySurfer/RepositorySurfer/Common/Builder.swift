//
//  Builder.swift
//  RepositorySurfer
//
//  Created by Jeongsik Lee on 2020/02/26.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import UIKit

enum Storyboard: String {
    case main = "Main"
    case repositories = "Repositories"
}

class Builder {
    
    // MARK: - Common initializer
    
    static func initiate<T>(from storyboard: Storyboard) -> T {
        let storyboard = UIStoryboard.init(name: storyboard.rawValue, bundle: nil)
        let className = String(describing: T.self)
        let theVC = storyboard.instantiateViewController(withIdentifier: className) as! T
        return theVC
    }
    
    // MARK: - Scene specific
    
    static func buildUsersModule() -> UsersViewController {
        let view: UsersViewController = Builder.initiate(from: .main)
        let interactor = UsersInteractor()
        let presenter = UsersPresenter()
        let router = UsersRouter()
        // link
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.view = view
        return view
    }
    
    static func buildUserDetailModule(with user: User) -> UserDetailViewController {
        let view: UserDetailViewController = Builder.initiate(from: .repositories)
        let interactor = UserDetailInteractor()
        let presenter = UserDetailPresenter(with: user)
        let router = UserDetailRouter()
        // link
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.view = view
        return view
    }
    
    static func buildRepositoryModule(with repository: Repository) -> RepositoryViewController {
        let view: RepositoryViewController = Builder.initiate(from: .repositories)
        let interactor = RepositoryInteractor()
        let presenter = RepositoryPresenter(with: repository)
        let router = RepositoryRouter()
        // link
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.view = view
        return view
    }
}
