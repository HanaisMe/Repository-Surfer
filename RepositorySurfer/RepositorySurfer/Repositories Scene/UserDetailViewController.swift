//
//  UserDetailViewController.swift
//  RepositorySurfer
//
//  Created by Jeongsik Lee on 2020/02/26.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    var user: User!
    @IBOutlet weak var iconImageview: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    
    var fetchUserDetailStatus = false
    var fetchUserFollowersStatus = false
    var fetchUserFollowingsStatus = false
    @IBOutlet weak var userInfoView: UIView!
    @IBOutlet weak var userInfoViewHeightConstraint: NSLayoutConstraint!
    
    var repositories = [Repository]()
    @IBOutlet weak var repositoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "@\(user.name)"
        repositoryTableView.dataSource = self
        repositoryTableView.delegate = self
    }
    
    func initFetchUserInfoStatus() {
        fetchUserDetailStatus = false
        fetchUserFollowersStatus = false
        fetchUserFollowingsStatus = false
    }
    
    func checkFetchUserInfoStatus() {
        if fetchUserDetailStatus, fetchUserFollowersStatus, fetchUserFollowingsStatus {
            showUserInfoViewWithAnimation()
        }
    }
    
    func showUserInfoViewWithAnimation(duration: TimeInterval = 0.5) {
        self.viewWillLayoutSubviews()
        UIView.animate(withDuration: duration, animations: {
            self.userInfoViewHeightConstraint.constant = 200
            self.userInfoView.layoutIfNeeded()
        }, completion: { _ in
            self.showRepositoriesWithAnimation()
        })
    }
    
    func showRepositoriesWithAnimation(duration: TimeInterval = 1) {
        self.viewWillLayoutSubviews()
        UIView.animate(withDuration: duration, animations: {
            self.repositoryTableView.isHidden = false
            self.repositoryTableView.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        iconImageview.loadImage(from: user.icon)
        
        initFetchUserInfoStatus()
        repositoryTableView.isHidden = true
        userInfoViewHeightConstraint.constant = 90
        
        Worker().fetchUserDetail(from: user, success: { [weak self] (userDetail) in
            self?.fetchUserDetailStatus = true
            self?.checkFetchUserInfoStatus()
            self?.user = userDetail // refresh data
            DispatchQueue.main.async {
                self?.fullNameLabel.text = userDetail.fullName
            }
        }, failure: { errorMessage in
            // TODO: - handle error
            print(errorMessage)
        })
        
        Worker().fetchUserFollowers(from: user, success: { [weak self] (followers) in
            self?.fetchUserFollowersStatus = true
            self?.checkFetchUserInfoStatus()
            DispatchQueue.main.async {
                self?.followerCountLabel.text = String(followers.count)
            }
        }, failure: { errorMessage in
            // TODO: - handle error
            print(errorMessage)
        })
                                      
        Worker().fetchUserFollowings(from: user, success: {[weak self] (followings) in
            self?.fetchUserFollowingsStatus = true
            self?.checkFetchUserInfoStatus()
            DispatchQueue.main.async {
                self?.followingCountLabel.text = String(followings.count)
            }
        }, failure: { errorMessage in
            // TODO: - handle error
            print(errorMessage)
        })
        
        Worker().fetchRepositories(from: user, success: { [weak self] (repositories) in
            self?.repositories = repositories
            self?.checkFetchUserInfoStatus()
            DispatchQueue.main.async {
                self?.repositoryTableView.reloadData()
            }
        }, failure: { errorMessage in
            // TODO: - handle error
            print(errorMessage)
        })
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension UserDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryTableViewCell_ID", for: indexPath) as! RepositoryTableViewCell
        cell.setUI(with: repositories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: - go to repository
    }
}
