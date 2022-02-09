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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: Button
extension SignInViewController {
    @IBAction func OKBtn(_ sender: Any) {
        let signIn = AuthModel()
        signIn.signIn(email: emailText.text!, pwd: pwdText.text!, vc: self)
    }
}

