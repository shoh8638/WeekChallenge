//
//  LoginViewController.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/09.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var pwdText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: Button
extension LoginViewController {
    @IBAction func loginBtn(_ sender: Any) {
       let auth = AuthModel()
        auth.login(email: emailText.text!, pwd: pwdText.text!, vc: self)
    }
    
    @IBAction func signInBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInView")
        vc?.modalPresentationStyle = .fullScreen
        vc?.modalTransitionStyle = .crossDissolve
        self.present(vc!, animated: true, completion: nil)
    }
}
