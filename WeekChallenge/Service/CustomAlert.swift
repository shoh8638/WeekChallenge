//
//  CustomAlert.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/14.
//

import UIKit
import SwiftOverlays

class CustomAlert {
    func loginAlert(message: String, vc: UIViewController) {
        let loginVC = vc.storyboard?.instantiateViewController(withIdentifier: "LoginView") as! LoginVC
        loginVC.modalPresentationStyle = .fullScreen
        loginVC.modalTransitionStyle = .crossDissolve
        
        let alert = UIAlertController(title: "알림" , message: message , preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default) { _ in
            vc.present(loginVC, animated: true, completion: nil)
        }
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
    
    func mainAlert(email: String, message: String, vc: UIViewController) {
        let mainVC = vc.storyboard?.instantiateViewController(withIdentifier: "MainView") as! MainVC
        mainVC.modalTransitionStyle = .crossDissolve
        mainVC.modalPresentationStyle = .fullScreen
        
        let alert = UIAlertController(title: "알림" , message: message , preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default) { _ in
            vc.present(mainVC, animated: true, completion: nil)
        }
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
    
    func failAlert(message: String, vc: UIViewController) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(action)
        vc.present(alert, animated: true) {
            vc.removeAllOverlays()
        }
    }
    
    func checkAlert(message: String, vc: UIViewController) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        let loginVC = vc.storyboard?.instantiateViewController(withIdentifier: "LoginView") as! LoginVC
        loginVC.modalPresentationStyle = .fullScreen
        loginVC.modalTransitionStyle = .crossDissolve
        
        alert.addAction(action)
        vc.present(alert, animated: true) {
            vc.removeAllOverlays()
            vc.dismiss(animated: true, completion: nil)
            vc.present(loginVC, animated: true, completion: nil)
        }
    }
}
