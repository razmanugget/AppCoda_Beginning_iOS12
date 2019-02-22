//
//  WebViewController.swift
//  FoodPin
//
//  Created by Rami on 2/21/19.
//  Copyright © 2019 LyfeBug. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    var targetURL = ""
    
    @IBOutlet var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
        
        if let url = URL(string: targetURL) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
}
