//
//  RepositoryViewController.swift
//  RepositorySurfer
//
//  Created by Jeongsik Lee on 2020/02/26.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import UIKit
import WebKit

class RepositoryViewController: UIViewController, ViperView {

    typealias PresenterType = RepositoryPresenter
    var presenter: PresenterType?
    
    @IBOutlet weak var repositoryWebView: WKWebView!
    @IBOutlet weak var goBackButton: UIBarButtonItem!
    @IBOutlet weak var goForwardButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repositoryWebView.navigationDelegate = self
        
        // Note
        // There is a known bug in WKWebView which displays console warning as following:
        // [Process] kill() returned unexpected error 1
        // Reference: https://stackoverflow.com/a/58539626
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.setupView()
    }
    
    func loadRepositoryWebKit(with repository: Repository) {
        let request = URLRequest(url: repository.url)
        repositoryWebView.load(request)
    }
    
    @IBAction func reloadButtonTapped(_ sender: Any) {
        repositoryWebView.stopLoading()
        
        if repositoryWebView.url != nil {
            repositoryWebView.reload()
        } else {
            presenter?.setupView()
        }
    }
    
    @IBAction func goBackButtonTapped(_ sender: Any) {
        repositoryWebView.goBack()
    }
    
    @IBAction func goForwardButtonTapped(_ sender: Any) {
        repositoryWebView.goForward()
    }
}

// MARK: - WKNavigationDelegate

extension RepositoryViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        goBackButton.isEnabled = repositoryWebView.canGoBack
        goForwardButton.isEnabled = repositoryWebView.canGoForward
    }
}
