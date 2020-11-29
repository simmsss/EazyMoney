//
//  StockDetail.swift
//  EazyMoney
//
//  Created by Simran Gogia and Utkarsh Sharma on 29/11/20.
//

import UIKit
import WebKit
import Alamofire
import SwiftyJSON
import CDAlertView

class StockDetail: UIViewController {
    
    @IBOutlet weak var companyLbl: UILabel!
    @IBOutlet weak var symbolLbl: UILabel!
    
    var stockSymbol: String?
    var stockName: String?
    var quantity = "1"
    var orderType = "market"

    @IBOutlet weak var webview: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        // Do any additional setup after loading the view.
        
        companyLbl.text = stockName
        symbolLbl.text = stockSymbol
        
        if let url = URL(string: "https://in.finance.yahoo.com/chart/\(stockSymbol ?? "AAPL")") {
            let request = URLRequest(url: url)
            webview.load(request)
        }
    }
    
    @IBAction func buyBtnPressed(_ sender: Any) {
        showSimpleActionSheet(controller: self)
    }
    
    @IBAction func sellBtnPressed(_ sender: Any) {
        showSimpleActionSheetSell(controller: self)
    }
    
    func showSimpleActionSheetSell(controller: UIViewController) {
        let alert = UIAlertController(title: "Order Type", message: "Please select a sell order type", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Market Order", style: .default, handler: { (_) in
            self.showAlertWithTextFieldSell()
        }))

        alert.addAction(UIAlertAction(title: "Limit Order", style: .default, handler: { (_) in
            self.showAlertWithTextFieldSell()
        }))

        alert.addAction(UIAlertAction(title: "Stoploss Order", style: .default, handler: { (_) in
            self.showAlertWithTextFieldSell()
        }))

        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_) in
            self.showAlertWithTextFieldSell()
        }))

        self.present(alert, animated: true, completion: {
            
        })
    }
    
    func showSimpleActionSheet(controller: UIViewController) {
        let alert = UIAlertController(title: "Order Type", message: "Please select a buy order type", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Market Order", style: .default, handler: { (_) in
            self.showAlertWithTextField()
        }))

        alert.addAction(UIAlertAction(title: "Limit Order", style: .default, handler: { (_) in
            self.showAlertWithTextField()
        }))

        alert.addAction(UIAlertAction(title: "Stoploss Order", style: .default, handler: { (_) in
            self.showAlertWithTextField()
        }))

        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_) in
            self.showAlertWithTextField()
        }))

        self.present(alert, animated: true, completion: {
            
        })
    }
    
    func showAlertWithTextFieldSell() {
        let alertController = UIAlertController(title: "Enter quantity", message: nil, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Add", style: .default) { (_) in
            if let txtField = alertController.textFields?.first, let text = txtField.text {
                let endpoint = "https://paper-api.alpaca.markets/v2/orders"
                
                self.quantity = text
                
                let parameters = ["symbol": self.stockSymbol!, "qty": self.quantity,
                                  "side": "sell", "type": self.orderType,
                                  "time_in_force": "day"] as [String : Any]
                
                let headers: HTTPHeaders = [
                  "APCA-API-KEY-ID": "PKKF4RB30X5070KLLI14",
                  "APCA-API-SECRET-KEY": "PqngSsBHFMYt68YSvRb0fmNCPLuQNondXLCYdmVz"
                ]
                
                AF.request(endpoint, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                    .responseData {  response in
                        guard let data = response.data else { return }
                        let json = try? JSON(data: data)
                        
                        if let json = json {
                            let dict = convertToDictionary(text: json.debugDescription)
                            for (_, value) in dict! {
                                if let _value = value as? String {
                                    let alert = CDAlertView(title: "Order Placed", message: "Your sell order for \(self.stockName) has been placed. It will reflect in your portfolio once accepted.", type: .notification)
                                    let doneAction = CDAlertViewAction(title: "Yay! 🤑")
                                    alert.add(action: doneAction)
                                    alert.show()
                                                
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
                                        nextViewController.modalPresentationStyle = .fullScreen
                                        self.present(nextViewController, animated:true, completion:nil)
                                    }
                                }
                            }
                        }
                    }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = "Quantity"
            textField.keyboardType = .decimalPad
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertWithTextField() {
        let alertController = UIAlertController(title: "Enter quantity", message: nil, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Add", style: .default) { (_) in
            if let txtField = alertController.textFields?.first, let text = txtField.text {
                let endpoint = "https://paper-api.alpaca.markets/v2/orders"
                
                self.quantity = text
                
                let parameters = ["symbol": self.stockSymbol!, "qty": self.quantity,
                                  "side": "buy", "type": self.orderType,
                                  "time_in_force": "day"] as [String : Any]
                
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
                                    if(_value == "accepted"){
                                        let alert = CDAlertView(title: "Order Placed", message: "Your buy order for \(self.stockName) has been placed. It will reflect in your portfolio once accepted.", type: .notification)
                                        let doneAction = CDAlertViewAction(title: "Yay! 🤑")
                                        alert.add(action: doneAction)
                                        alert.show()
                                                    
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
                                            nextViewController.modalPresentationStyle = .fullScreen
                                            self.present(nextViewController, animated:true, completion:nil)
                                        }
                                    }
                                }
                            }
                        }
                    }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = "Quantity"
            textField.keyboardType = .decimalPad
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
