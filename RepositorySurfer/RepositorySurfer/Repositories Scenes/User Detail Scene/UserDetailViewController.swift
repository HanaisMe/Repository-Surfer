//
//  UserDetailViewController.swift
//  RepositorySurfer
//
//  Created by Jeongsik Lee on 2020/02/26.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController, ViperView {

    typealias PresenterType = UserDetailPresenter
    var presenter: PresenterType?
    
    @IBOutlet weak var userInfoView: UIView!
    @IBOutlet weak var userInfoViewHeightConstraint: NSLayoutConstraint!
    // MARK: - User Details
    @IBOutlet weak var iconImageview: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    // MARK: - User Repositories
    @IBOutlet weak var repositoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repositoryTableView.dataSource = self
        repositoryTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // MARK: - User
        presenter?.fetchBasicUserInfo()
        // MARK: - User Details
        repositoryTableView.isHidden = true
        userInfoViewHeightConstraint.constant = 90
        presenter?.fetchDetailedUserInfo()
    }
    
    // MARK: - User
    
    func setBasicUserInfo(_ user: User) {
        title = "@\(user.name)"
        iconImageview.loadImage(from: user.icon)
    }
    
    // MARK: - User Details
    
    func showUserInfoViewWithAnimation(duration: TimeInterval = 0.5) {
        self.viewWillLayoutSubviews()
        UIView.animate(withDuration: duration, animations: {
            self.userInfoViewHeightConstraint.constant = 200
            self.userInfoView.layoutIfNeeded()
        }, completion: { _ in
            self.showRepositoriesWithAnimation()
        })
    }
    
    func setDetailedUserInfo(fullName: String?) {
        DispatchQueue.main.async {
            self.fullNameLabel.text = fullName
        }
    }
    
    func setDetailedUserInfo(followersCount: Int) {
        DispatchQueue.main.async {
            self.followerCountLabel.text = String(followersCount)
        }
    }
    
    func setDetailedUserInfo(followingsCount: Int) {
        DispatchQueue.main.async {
            self.followingCountLabel.text = String(followingsCount)
        }
    }
    
    // MARK: - User Repositories
    
    func reloadUserRepositories() {
        DispatchQueue.main.async {
            self.repositoryTableView.reloadData()
        }
    }
    
    func showRepositoriesWithAnimation(duration: TimeInterval = 1) {
        self.viewWillLayoutSubviews()
        UIView.animate(withDuration: duration, animations: {
            self.repositoryTableView.isHidden = false
            self.repositoryTableView.layoutIfNeeded()
        }, completion: nil)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension UserDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getRepositoriesCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryTableViewCell_ID", for: indexPath) as! RepositoryTableViewCell
        if let repository = presenter?.getRepository(at: indexPath.row) {
            cell.setUI(with: repository)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectRepository(at: indexPath.row)
    }
}
