//
//  WriteVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/23.
//

import UIKit
import Firebase

class WriteVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func checkUser() {
        if let userID = Auth.auth().currentUser?.email {
            Database().checkDB(userID: userID) { count in
                
            }
        }
    }
}
