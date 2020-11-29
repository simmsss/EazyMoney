//
//  ViewController.swift
//  EazyMoney
//
//  Created by Simran Gogia and Utkarsh Sharma on 29/11/20.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var balanceLbl: UILabel!
    @IBOutlet weak var portfolioValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        balanceLbl.text = "$ \(bankbalance)"
        portfolioValue.text = "$ \(portvalue)"
    }


}
