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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        guard let userID = Auth.auth().currentUser?.email else { return }
        guard let dbID = self.documentID else { return }
        for i in dbID {
            self.db.collection(userID).document(i).getDocument { (document, err) in
                guard err == nil else { return }
                let dates = (document!["Dates"] as! [String]).sorted(by: <)
                if dates.contains(self.date!) {
                    self.titles.append(document!["Title"] as! String)
                    self.firstPeriod.append(dates.first!)
                    self.lastPeriod.append(dates.last!)
                    print(document!["Title"] as! String)
                    print(dates.first!)
                    print(dates.last!)
                }
            }
        }
        
    }
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
