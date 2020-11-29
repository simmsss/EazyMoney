//
//  plaidview.swift
//  EazyMoney
//
//  Created by Utkarsh Sharma on 29/11/20.
//

import UIKit
import WebKit

class plaidview: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: "https://cdn.plaid.com/link/v2/stable/link.html?token=link-sandbox-e8bc1e32-6cda-430f-a65d-50abf48def7e") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

}
