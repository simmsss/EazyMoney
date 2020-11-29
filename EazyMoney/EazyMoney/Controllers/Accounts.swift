//
//  Accounts.swift
//  EazyMoney
//
//  Created by Simran Gogia and Utkarsh Sharma on 29/11/20.
//

import UIKit

class Accounts: UIViewController {

    @IBOutlet weak var balanceLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        balanceLbl.text = "$ \(bankbalance)"
        // Do any additional setup after loading the view.
    }

}
