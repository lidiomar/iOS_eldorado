//
//  WebviewViewController.swift
//  F1Project
//
//  Created by T1aluno09 on 18/05/18.
//  Copyright © 2018 T1aluno09. All rights reserved.
//

import UIKit
import WebKit
class WebviewViewController: UIViewController, WKNavigationDelegate {
    var url: String!

    @IBOutlet var webView: WKWebView!
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: url)
        let myRequest = URLRequest(url: myURL!)
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        webView.load(myRequest)
        webView.navigationDelegate = self
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.stopAnimating()
    }
}

