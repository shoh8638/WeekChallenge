//
//  SignInViewController.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/09.
//

import UIKit

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
//MARK: Button
extension SignInViewController {
    @IBAction func OKBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginView")
        vc?.modalPresentationStyle = .fullScreen
        vc?.modalTransitionStyle = .crossDissolve
        
        let alert = UIAlertController(title: "" , message: "" , preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default) { _ in
            self.present(vc!, animated: true, completion: nil)
        }
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
}

