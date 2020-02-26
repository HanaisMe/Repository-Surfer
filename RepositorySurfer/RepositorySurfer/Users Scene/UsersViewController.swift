//
//  UsersViewController.swift
//  RepositorySurfer
//
//  Created by Jeongsik Lee on 2020/02/26.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    @IBOutlet weak var userTableView: UITableView!
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "GitHub Users"
        userTableView.dataSource = self
        userTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Worker().fetchUsers(success: { [weak self] (users) in
            self?.users = users
            DispatchQueue.main.async {
                self?.userTableView.reloadData()
            }
        }, failure: { errorMessage in
            // TODO: - handle error
            print(errorMessage)
        })
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell_ID", for: indexPath) as! UserTableViewCell
        cell.setUI(with: users[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = users[indexPath.row]
        let userDetailVC = Builder.buildUserDetailScene(with: selectedUser)
        self.navigationController?.pushViewController(userDetailVC, animated: true)
    }
}
