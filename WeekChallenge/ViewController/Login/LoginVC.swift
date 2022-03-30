//
//  LoginVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/09.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var pwdText: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectService().Network(view: self)
        autoLogin()
        if emailText != nil {
            emailText.delegate = self
            pwdText.delegate = self
            loginBtn.isEnabled = false
            loginBtn.backgroundColor = .lightGray
        }
    }
    
    func autoLogin() {
        if Auth.auth().currentUser?.email != nil {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainView")
            vc?.modalPresentationStyle = .fullScreen
            vc?.modalTransitionStyle = .flipHorizontal
            self.present(vc!, animated: true)
        }
    }
}

//MARK: Button
extension LoginVC {
    @IBAction func loginBtn(_ sender: Any) {
        print("LoginView: LoginBtn")
        let auth = AuthService()
        auth.login(email: emailText.text!, pwd: pwdText.text!, vc: self)
    }
    
    @IBAction func signInBtn(_ sender: Any) {
        print("LoginView: SignInBtn")
    }
}

//MARK: TextFieldDelegate
extension LoginVC: UITextFieldDelegate {
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
            loginBtn.isEnabled = true
            loginBtn.backgroundColor = UIColor(red: 1.0, green: 22.0/255.0, blue: 84.0/255.0, alpha: 1.0)
        } else {
            loginBtn.isEnabled = false
            loginBtn.backgroundColor = .lightGray
        }
        return true
    }
}

