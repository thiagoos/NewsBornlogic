//
//  NewsWebViewController.swift
//  NewsBornlogic
//
//  Created by Thiago Soares on 23/03/22.
//

import UIKit
import WebKit

class NewsWebViewController: UIViewController, WKNavigationDelegate {
    // MARK: - Variable
    var url: URL
    
    // MARK: - UI
    fileprivate lazy  var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    // MARK: - Life Cycle
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    init(url: URL, source: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
        self.title = source
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    // MARK: - Function
    fileprivate func setupController() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .never
        
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}
