//
//  EducateVC.swift
//  EazyMoney
//
//  Created by Simran Gogia and Utkarsh Sharma on 29/11/20.
//

import UIKit
import CDAlertView
import Alamofire
import SwiftyJSON
import AudioToolbox

class EducateVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var newsCollectionView: UICollectionView!
    @IBOutlet weak var highlightLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNews()
        newsCollectionView.reloadData()
        
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
    }
    
    var newsTitlesDict:[Int: String] = [:]
    var newsAuthorDict:[Int: String] = [:]
    var newsUrl:[Int: String] = [:]
    var newsImageDict:[Int: String] = [:]
    var newsPublishedDict:[Int: String] = [:]
    var newsImages:[Int: UIImage] = [:]
    
    @IBAction func newsofthedaybtn(_ sender: Any) {
        let url = "https://www.cnbctv18.com/market/stocks/sebi-cautions-investors-against-unsolicited-investment-tips-7219021.htm"
        
        if let url = URL(string: url) {
            UIApplication.shared.open(url)
        }
    }
    
    // TODO: WordsOfWisdomButtons
    @IBAction func warrenBuffetBtnPressed(_ sender: Any) {
        let alert = CDAlertView(title: "Words of Wisdom", message: warren.randomElement(), type: .notification)
        let doneAction = CDAlertViewAction(title: "Coooool! 🤑")
        alert.add(action: doneAction)
        alert.show()
    }
    
    @IBAction func elonMuskBtnPressed(_ sender: Any) {
        let alert = CDAlertView(title: "Words of Wisdom", message: elon.randomElement(), type: .notification)
        let doneAction = CDAlertViewAction(title: "Coooool! 🤑")
        alert.add(action: doneAction)
        alert.show()
    }
    
    @IBAction func peterLynchBtnPressed(_ sender: Any) {
        let alert = CDAlertView(title: "Words of Wisdom", message: peter.randomElement()!, type: .notification)
        let doneAction = CDAlertViewAction(title: "Coooool! 🤑")
        alert.add(action: doneAction)
        alert.show()
    }
    
    @IBAction func steveJobsBtnPressed(_ sender: Any) {
        let alert = CDAlertView(title: "Words of Wisdom", message: steve.randomElement(), type: .notification)
        let doneAction = CDAlertViewAction(title: "Coooool! 🤑")
        alert.add(action: doneAction)
        alert.show()
    }
    
    @IBAction func billAckmanBtnPressed(_ sender: Any) {
        let alert = CDAlertView(title: "Words of Wisdom", message: bill.randomElement(), type: .notification)
        let doneAction = CDAlertViewAction(title: "Coooool! 🤑")
        alert.add(action: doneAction)
        alert.show()
    }
    
    @IBAction func markCubanBtnPressed(_ sender: Any) {
        let alert = CDAlertView(title: "Words of Wisdom", message: mark.randomElement(), type: .notification)
        let doneAction = CDAlertViewAction(title: "Coooool! 🤑")
        alert.add(action: doneAction)
        alert.show()
    }
    
    func getNews() {
            let now = Date()
            let oneMonthBefore = now.adding(months: -1)!
            
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            let date = df.string(from: oneMonthBefore)
            
            let url : String = "http://newsapi.org/v2/everything?q=AAPL&from=\(date)&sortBy=publishedAt&apiKey=acb1beb15863493ebbf20fc7aae5c65b"
            
            AF.request(url).responseJSON { response in
                print(response)
                let value = response.value as? NSDictionary
                print(value)
                  if ((value) != nil) {
                      
                    var counter = 0
                    
                    let json = JSON(value!)
                    let status = json["status"]
                    if(status == "ok"){
                        for (key, subjson):(String, JSON) in json {
                          if(key=="articles"){
                            for(_, subsub):(String, JSON) in subjson {
                                self.newsTitlesDict[counter] = subsub["title"].stringValue
                                self.newsAuthorDict[counter] = subsub["source"]["name"].stringValue
                                self.newsUrl[counter] = subsub["url"].stringValue
                                self.newsImageDict[counter] = subsub["urlToImage"].stringValue
                                
                                var date = subsub["publishedAt"].stringValue
                                if let dotRange = date.range(of: "T") {
                                    date.removeSubrange(dotRange.lowerBound..<date.endIndex)
                                }
                                
                                self.newsPublishedDict[counter] = date
                                counter = counter + 1
                            }
                          }
                        }
                        
                        self.newsCollectionView.reloadData()
                    } else {
                        let alert = CDAlertView(title: "Oops, something's not right!", message: "No news to show. We'll be back with more.", type: .error)
                        let doneAction = CDAlertViewAction(title: "Sure! 💪")
                        alert.add(action: doneAction)
                        alert.show()
                        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    }
                  }
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return newsTitlesDict.count
        }
            
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as? NewsCell
            cell?.newsTitleLbl.text = newsTitlesDict[indexPath.row]
            
            return cell!
        }

}
