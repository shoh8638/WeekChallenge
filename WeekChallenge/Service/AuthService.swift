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
    var userID: String = ""
    
    func login(email: String, pwd: String, vc: UIViewController){
        vc.showTextOverlay("please Wait....")
        Auth.auth().signIn(withEmail: email, password: pwd) { authResult, error in
            if authResult != nil {
                vc.removeAllOverlays()
                print("LoginView Success")
                self.userID = email
                
                let customAlert = CustomAlert()
                customAlert.mainAlert(email: email, message: "로그인 완료", vc: vc)
            } else {
                print("LoginView Failure")
                
                let customAelrt = CustomAlert()
                customAelrt.failAlert(message: "로그인 실패", vc: vc)
            }
        }
    }
    
    func signIn(email: String, pwd: String, username: String, vc: UIViewController, img: String) {
        vc.showTextOverlay("please Wait....")
        Auth.auth().createUser(withEmail: email, password: pwd) { authResult, error in
            if authResult != nil {
                vc.removeAllOverlays()
                print("SignInView Success")
                
                let db = Database()
                db.signInDB(id: email, email: email, pwd: pwd, username: username, img: img)
                
                let customAlert = CustomAlert()
                customAlert.loginAlert(message: "회원가입 완료", vc: vc)
            } else {
                vc.removeAllOverlays()
                print("SignInView Failure")
                
                let customAelrt = CustomAlert()
                customAelrt.failAlert(message: "회원가입 실패", vc: vc)
            }
        }
    }
}
