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
        emailText.delegate = self
        pwdText.delegate = self
        signInBtn.isEnabled = false
        signInBtn.backgroundColor = .lightGray
    }
}

//MARK: Button
extension SignInViewController {
    @IBAction func signInBtn(_ sender: Any) {
        let auth = AuthService()
        auth.signIn(email: emailText.text!, pwd: pwdText.text!, vc: self)
    }
}

//MARK: TextFieldDelegate
extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailText {
            pwdText.becomeFirstResponder()
        } else {
            pwdText.resignFirstResponder()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
   }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if emailText.text!.count > 5 && pwdText.text!.count > 5 {
            signInBtn.isEnabled = true
            signInBtn.backgroundColor = UIColor(red: 1.0, green: 22.0/255.0, blue: 84.0/255.0, alpha: 1.0)
        } else {
            signInBtn.isEnabled = false
            signInBtn.backgroundColor = .lightGray
        }
        return true
    }
}
