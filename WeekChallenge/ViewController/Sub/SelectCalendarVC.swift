//
//  SelectCalendarVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/10.
//

import UIKit
import Firebase

class SelectCalendarVC: UIViewController {

    var documentID: [String]?
    var date: String?
    let db = Firestore.firestore()
    var titles = [String]()
    var firstPeriod = [String]()
    var lastPeriod = [String]()
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var selectCalendar: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        self.backView.layer.cornerRadius = 20
        self.backView.layer.masksToBounds = true
    }
    
    func loadData() {
        var complete = [Int]()
        
        guard let userID = Auth.auth().currentUser?.email else { return }
        self.db.collection(userID).addSnapshotListener {(querySnapshot, err) in
            
            if err == nil {
                for document in querySnapshot!.documents {
                    if document.documentID != "UserData" {
                        let dates = (document["Dates"] as! [String]).sorted(by: <)
                        
                        for number in 0...dates.count-1 {
                            let dateFields = document[dates[number]] as! [String: String]
                            let text = dateFields["Text"]!
                            if text == "" {
                                complete.append(0)
                            } else {
                                complete.append(3)
                            }
                        }
                        
                        if dates.contains(self.date!) {
                            self.titles.append(document["Title"] as! String)
                            self.firstPeriod.append(dates.first!)
                            self.lastPeriod.append(dates.last!)
                        }
                        
                        if !complete.contains(0) {
                            if let index = self.titles.firstIndex(of: document["Title"] as! String){
                                self.titles.remove(at: index)
                            }
                            
                            if let index = self.firstPeriod.firstIndex(of: dates.first!) {
                                self.firstPeriod.remove(at: index)
                            }
                            
                            if let index = self.lastPeriod.firstIndex(of: dates.last!) {
                                
                                self.lastPeriod.remove(at: index)
                            }
                        }
                        complete.removeAll()
                    }
                }
            }
            self.selectCalendar.reloadData()
        }
    }
    
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
//MARK: UITableView
extension SelectCalendarVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.titles.count == 0 {
            return 1
        } else {
            return self.titles.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.titles.count == 0 {
            let cell = selectCalendar.dequeueReusableCell(withIdentifier: "homeEmptyCell", for: indexPath) as! homeEmptyCell
            cell.title.text = "아무것도 없어요"
            cell.periodText.text = "아무것도 없어요"
            return cell
        } else {
            let cell = selectCalendar.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! homeCell
            cell.title.text = self.titles[indexPath.row]
            cell.periodText.text = "\(self.firstPeriod[indexPath.row]) ~ \(self.lastPeriod[indexPath.row])"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.titles.count == 0 {
            return self.selectCalendar.frame.height
        } else {
            return self.selectCalendar.frame.height/3
        }
    }
}
