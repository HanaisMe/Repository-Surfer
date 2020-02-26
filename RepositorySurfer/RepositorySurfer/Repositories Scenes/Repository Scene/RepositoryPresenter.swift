//
//  RepositoryPresenter.swift
//  RepositorySurfer
//
//  Created by Jeongsik Lee on 2020/02/26.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import Foundation

class RepositoryPresenter: NSObject, ViperPresenter {
    
    typealias InteractorType = RepositoryInteractor
    typealias RouterType = RepositoryRouter
   
    weak var view: RepositoryViewController?
    var interactor: InteractorType?
    var router: RouterType?
    
    private var repository: Repository?
    
    convenience init(with repository: Repository) {
        self.init()
        self.repository = repository
    }
    
    func setupView() {
        guard let repository = repository else { return }
        view?.loadRepositoryWebKit(with: repository)
    }
}
