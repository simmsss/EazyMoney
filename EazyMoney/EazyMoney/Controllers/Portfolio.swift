//
//  Portfolio.swift
//  EazyMoney
//
//  Created by Simran Gogia and Utkarsh Sharma on 29/11/20.
//

import UIKit
import Alamofire
import SwiftyJSON

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
        
        let parameters = ["symbol": "AAPL", "qty": "6",
                          "side": "buy", "type": "market",
                          "time_in_force": "day"]
        
        let headers: HTTPHeaders = [
          "APCA-API-KEY-ID": "PKKF4RB30X5070KLLI14",
          "APCA-API-SECRET-KEY": "PqngSsBHFMYt68YSvRb0fmNCPLuQNondXLCYdmVz"
        ]
        
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseData {  response in
                guard let data = response.data else { return }
                let json = try? JSON(data: data)
                print(json)
                if let json = json {
                    let dict = convertToDictionary(text: json.debugDescription)
                    for (_, value) in dict! {
                        if let _value = value as? String {
                            print(_value)
                        }
                    }
                }
            }
    }
    
}
