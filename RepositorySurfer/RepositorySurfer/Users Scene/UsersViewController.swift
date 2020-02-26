//
//  UsersViewController.swift
//  RepositorySurfer
//
//  Created by Jeongsik Lee on 2020/02/26.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController, ViperView {

    typealias PresenterType = UsersPresenter
    var presenter: PresenterType?
    
    @IBOutlet weak var userTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "GitHub Users"
        userTableView.dataSource = self
        userTableView.delegate = self
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.userTableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.fetchUsers()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getUsersCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell_ID", for: indexPath) as! UserTableViewCell
        if let user = presenter?.getUser(at: indexPath.row) {
            cell.setUI(with: user)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectUser(at: indexPath.row)
    }
}
