//
//  ChangePWD.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/16.
//

import UIKit
import Firebase
import FirebaseFirestore
import SwiftOverlays

class ChangePWD: UIViewController {
    
    @IBOutlet weak var changeText: UITextField!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    @IBAction func changePWDBtn(_ sender: Any) {
        self.showTextOverlay("please Wait....")
        Auth.auth().currentUser?.updatePassword(to: changeText.text!) { error in
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

extension ChangePWD: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if changeText.text!.count > 5 {
            button.isEnabled = true
            button.backgroundColor = UIColor(red: 1.0, green: 22.0/255.0, blue: 84.0/255.0, alpha: 1.0)
        } else {
            button.isEnabled = false
            button.backgroundColor = .lightGray
        }
        return true
    }
}
