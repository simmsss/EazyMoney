//
//  SearchVC.swift
//  EazyMoney
//
//  Created by Simran Gogia and Utkarsh Sharma on 29/11/20.
//

import UIKit
import Alamofire
import SwiftyJSON
import SAConfettiView
import CDAlertView

class SearchVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {

    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: Class Variables
    var symbols: [String] = []
    private var filteredSymbols = [String]()
    var similarSymbols: [String] = []
    let exchange = "osaka_symbols"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ViewDidLoad")
        
        print("Request...")
        
        self.tableView.isHidden = true
        
        AF.request("https://pkgstore.datahub.io/core/nasdaq-listings/nasdaq-listed_json/data/a5bc7580d6176d60ac0b2142ca8d7df6/nasdaq-listed_json.json", method: .get).responseData { (response) in
                        
            self.symbols.removeAll()
            
            guard let data = response.data else { return }
            let json = try! JSON(data: data)
            
            for (key, subjson):(String, JSON) in json {
                let symbol = subjson["Symbol"].stringValue
                self.symbols.append(symbol)
            }
            
            self.removeSpinner()
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }

        tableView.delegate = self
        tableView.dataSource = self
        
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchResultsUpdater = self
        
        tableView.reloadData()
    }
    
    // MARK: TableView Protocols
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return searchController.isActive ? filteredSymbols.count : symbols.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "SymbolCell") as! SymbolCell?
                    
            let symbol = searchController.isActive ? filteredSymbols[indexPath.row] : symbols[indexPath.row]
            
            cell!.symbolLabel.text = symbol
            cell?.selectionStyle = .none
            
            return cell!
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let symbol = searchController.isActive ? filteredSymbols[indexPath.row] : symbols[indexPath.row]
            
            self.showSpinner(onView: self.view)
            
            let url = "https://bearz-and-bullz.herokuapp.com/\(exchange )_symbols?Symbol=\(symbol)"
            print(url)
            
            AF.request(url, method: .post).responseData { (response) in
                self.similarSymbols.removeAll()
                
                print("Request...")
                
                guard let data = response.data else { return }
                let json = try? JSON(data: data)
                if let json = json {
                    let dict = convertToDictionary(text: json.debugDescription)
                    for (_, value) in dict! {
                        if let _value = value as? String {
                            self.similarSymbols.append(_value)
                        }
                    }
                }
                
                print(self.similarSymbols)
                
                let confettiView = SAConfettiView(frame: self.view.bounds)
                self.view.addSubview(confettiView)
                confettiView.startConfetti()
                
                var stringToShow = "Here are some recommendations tailored according to your existing investments: "
                
                var count = 0
                for element in self.similarSymbols {
                    if(count < 10){
                        stringToShow = stringToShow + "\n" + element
                    }
                    count+=1
                }
                
                let alert = CDAlertView(title: "Personalised Recommendations", message: stringToShow, type: .notification)
                let doneAction = CDAlertViewAction(title: "Yay! 🤑")
                alert.add(action: doneAction)
                alert.show()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 12.0) {
                    confettiView.stopConfetti()
                    
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
                    nextViewController.modalPresentationStyle = .fullScreen
                    self.present(nextViewController, animated:true, completion:nil)
                }
                
                self.removeSpinner()
            }
        }
        
        
        // MARK: Filter
        func updateSearchResults(for searchController: UISearchController) {
            filterSearchController(searchBar: searchController.searchBar)
        }
        
        func filterSearchController(searchBar: UISearchBar){
            let searchText = searchBar.text ?? ""
            
            filteredSymbols = symbols.filter { symbol in
                let isMatchingSearchText = symbol.lowercased().contains(searchText.lowercased()) || searchText.lowercased().count == 0
                return isMatchingSearchText
            }
            
            tableView.reloadData()
        }

}
