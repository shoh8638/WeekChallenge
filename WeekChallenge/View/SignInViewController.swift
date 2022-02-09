//
//  SignInViewController.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/09.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var pwdText: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.saveBtn(isOn: false)
    }
    
}

//MARK: Button
extension SignInViewController {
    @IBAction func changeBtnColor(_ sender: UITextField) {
        if sender.text?.isEmpty == true {
            self.saveBtn(isOn: false)
        } else {
            self.saveBtn(isOn: true)
            let signIn = AuthModel()
            signIn.signIn(email: emailText.text!, pwd: pwdText.text!, vc: self)
        }
        
    }
    func saveBtn(isOn: Bool) {
        switch isOn {
        case true :
            signInBtn.isEnabled = true
            signInBtn.backgroundColor = UIColor(red: 255.0, green: 22.0, blue: 84.0, alpha: 0)
        case false :
            signInBtn.isEnabled = false
            signInBtn.backgroundColor = .lightGray
        }
    }
}
