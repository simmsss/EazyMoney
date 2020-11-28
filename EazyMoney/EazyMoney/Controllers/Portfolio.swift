//
//  Portfolio.swift
//  EazyMoney
//
//  Created by Simran Gogia and Utkarsh Sharma on 29/11/20.
//

import UIKit
import Alamofire

class Portfolio: UIViewController {

    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var buyBtn: UIButton!
    @IBOutlet weak var sellBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func buyButton(_ sender: Any) {
        
    }
    
    @IBAction func sellBtn(_ sender: Any) {
        let endpoint = "https://paper-api.alpaca.markets/v2/orders"
        
        let parameters = ["symbol": "AAPL", "qty": "1",
                          "side": "buy", "type": "market",
                          "time_in_force": "day"]
        
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseData {  response in
                print(response)
            }
    }
    
}
