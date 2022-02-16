//
//  CreatePlanVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/16.
//

import UIKit
import Firebase

class CreatePlanVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: Button
extension CreatePlanVC {
    @IBAction func fiveDayPlan(_ sender: Any) {
        if let userID = Auth.auth().currentUser?.email {
            Database().createDB(userID: userID, folderName: "", date: [""])
        }
    }
    
    @IBAction func tenDayPlan(_ sender: Any) {
        if let userID = Auth.auth().currentUser?.email {
            Database().createDB(userID: userID, folderName: "", date: [""])
        }
    }
    
    @IBAction func fifteenDayPlan(_ sender: Any) {
        if let userID = Auth.auth().currentUser?.email {
            Database().createDB(userID: userID, folderName: "", date: [""])
        }
    }
}
