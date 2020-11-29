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
        valueLabel.text = "$ \(portvalue)"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sellBtn(_ sender: Any) {
        
    }
    
}
