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
    
    static func buildUsersScene() -> UsersViewController {
        let usersVC: UsersViewController = Builder.initiate(from: .main)
        return usersVC
    }
}
