//
//  SignOutVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/16.
//

import UIKit
import Firebase
import FirebaseFirestore
import SwiftOverlays

class SignOutVC: UIViewController {
    
    @IBOutlet weak var userIDText: UILabel!
    @IBOutlet weak var changePWD: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp() {
        if let userID = Auth.auth().currentUser?.email {
            self.userIDText.text = userID
        }
    }
    
    @IBAction func changePwdBtn(_ sender: Any) {
        self.showTextOverlay("please Wait....")
        Auth.auth().currentUser?.updatePassword(to: changePWD.text!) { error in
            if error == nil {
                print("ChangePWD Success")
                CustomAlert().checkAlert(message: "비밀번호 변경 성공", vc: self)
            } else {
                print("ChangePWD Fail")
                CustomAlert().checkAlert(message: "비밀번호 변경 실패", vc: self)
            }
        }
    }
}
