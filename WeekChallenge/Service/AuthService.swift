//
//  AuthService.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/09.
//

import Foundation
import FirebaseAuth
import SwiftOverlays

class AuthService {
    func login(email: String, pwd: String, vc: UIViewController) {
        vc.showTextOverlay("please Wait....")
        Auth.auth().signIn(withEmail: email, password: pwd) { authResult, error in
            if authResult != nil {
                vc.removeAllOverlays()
                print("LoginView Success")
                let mainVC = vc.storyboard?.instantiateViewController(withIdentifier: "MainView") as! MainViewController
                mainVC.modalTransitionStyle = .crossDissolve
                mainVC.modalPresentationStyle = .fullScreen
                vc.present(mainVC, animated: true, completion: nil)
            } else {
                print("LoginView Failure")
                let alert = UIAlertController(title: "알림", message: "로그인 실패", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(action)
                vc.present(alert, animated: true) {
                    vc.removeAllOverlays()
                }
            }
        }
    }
    
    func signIn(email: String, pwd: String, vc: UIViewController) {
        vc.showTextOverlay("please Wait....")
        Auth.auth().createUser(withEmail: email, password: pwd) { authResult, error in
            if authResult != nil {
                vc.removeAllOverlays()
                print("SignInView Success")
                let loginVC = vc.storyboard?.instantiateViewController(withIdentifier: "LoginView") as! LoginViewController
                loginVC.modalPresentationStyle = .fullScreen
                loginVC.modalTransitionStyle = .crossDissolve
                
                let alert = UIAlertController(title: "알림" , message: "회원가입 완료!" , preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .default) { _ in
                    vc.present(loginVC, animated: true, completion: nil)
                }
                alert.addAction(action)
                vc.present(alert, animated: true)
            } else {
                vc.removeAllOverlays()
                print("SignInView Failure")
                let alert = UIAlertController(title: "알림" , message: "회원가입 실패!" , preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(action)
                vc.present(alert, animated: true)
            }
        }
    }
}
