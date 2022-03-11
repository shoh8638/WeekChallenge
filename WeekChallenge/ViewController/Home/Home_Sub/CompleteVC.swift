//
//  CompleteVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/11.
//

import UIKit
import Firebase

class CompleteVC: UIViewController, UIGestureRecognizerDelegate {

    let db = Firestore.firestore()
    var titles = [String]()
    var firstPeriod = [String]()
    var lastPeriod = [String]()
    
    @IBOutlet weak var completeTable: UITableView!
    @IBOutlet weak var backView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backView.layer.cornerRadius = 20
        backView.layer.masksToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(backTap(sender:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        loadData()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @objc func backTap(sender: UITapGestureRecognizer) {
        print("tap")
        self.dismiss(animated: true, completion: nil)
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
                        if complete.contains(3) {
                            self.titles.append(document["Title"] as! String)
                            self.firstPeriod.append(dates.first!)
                            self.lastPeriod.append(dates.last!)
                        }
                        complete.removeAll()
                    }
                }
            }
            self.completeTable.reloadData()
        }
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CompleteVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.titles.count == 0 {
            return 1
        } else {
            return self.titles.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.titles.count == 0 {
            let cell = completeTable.dequeueReusableCell(withIdentifier: "homeEmptyCell", for: indexPath) as! homeEmptyCell
            cell.title.text = "아무것도 없어요"
            cell.periodText.text = "아무것도 없어요"
            return cell
        } else {
            let cell = completeTable.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! homeCell
            cell.title.text = self.titles[indexPath.row]
            cell.periodText.text = "\(self.firstPeriod[indexPath.row]) ~ \(self.lastPeriod[indexPath.row])"
            return cell
        }
    }
}

