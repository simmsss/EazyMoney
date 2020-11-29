//
//  StockDetail.swift
//  EazyMoney
//
//  Created by Simran Gogia and Utkarsh Sharma on 29/11/20.
//

import UIKit
import WebKit

class StockDetail: UIViewController {
    
    @IBOutlet weak var companyLbl: UILabel!
    @IBOutlet weak var symbolLbl: UILabel!
    
    var stockSymbol: String?
    var stockName: String?

    @IBOutlet weak var webview: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        // Do any additional setup after loading the view.
        
        companyLbl.text = stockName
        symbolLbl.text = stockSymbol
        
        if let url = URL(string: "https://in.finance.yahoo.com/chart/\(stockSymbol)") {
            let request = URLRequest(url: url)
            webview.load(request)
        }
    }
    
    @IBAction func buyBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func sellBtnPressed(_ sender: Any) {
        
    }
    
}
