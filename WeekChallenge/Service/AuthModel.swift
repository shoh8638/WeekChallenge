//
//  AuthModel.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/09.
//

import Foundation
import FirebaseAuth
import SwiftOverlays

class AuthModel {
    func login(email: String, pwd: String, vc: UIViewController) {
        vc.showTextOverlay("please Wait....")
        Auth.auth().signIn(withEmail: email, password: pwd) { authResult, error in
            if authResult != nil {
                let alert = UIAlertController(title: "알림", message: "로그인 성공", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(action)
                vc.present(alert, animated: true) {
                    vc.removeAllOverlays()
                }
            } else {
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
                print("SignInView Success")
                let loginVC = vc.storyboard?.instantiateViewController(withIdentifier: "LoginView")
                loginVC?.modalPresentationStyle = .fullScreen
                loginVC?.modalTransitionStyle = .crossDissolve
                
                let alert = UIAlertController(title: "알림" , message: "회원가입 완료!" , preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .default) { _ in
                    vc.present(loginVC!, animated: true, completion: nil)
                    vc.removeAllOverlays()
                }
                alert.addAction(action)
                vc.present(alert, animated: true) {
                    vc.removeAllOverlays()
                }
            } else {
                print("SignInView Failure")
                let alert = UIAlertController(title: "알림" , message: "회원가입 실패!" , preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(action)
                vc.present(alert, animated: true) {
                    vc.removeAllOverlays()
                }
            }
        }
    }
}
