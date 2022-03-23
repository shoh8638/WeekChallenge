//
//  AlertService.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/14.
//

import UIKit
import SwiftOverlays
import Firebase
import Pageboy

class AlertService {
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
        
        let loginVC = vc.storyboard?.instantiateViewController(withIdentifier: "LoginView") as! LoginVC
        loginVC.modalPresentationStyle = .fullScreen
        loginVC.modalTransitionStyle = .crossDissolve
        
        if message == "비밀번호 변경 성공" {
            let alert = UIAlertController(title: "알림" , message: message , preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default) { _ in
                vc.present(loginVC, animated: true, completion: nil)
            }
            alert.addAction(action)
            vc.present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "알림" , message: message , preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(action)
            vc.present(alert, animated: true)
        }
    }
    
    func createPlan(vc: UIViewController, day: String, date: [String:  Any]) {
        let alert = UIAlertController(title: "알림" , message: "\(day)플랜이 생성되었습니다!" , preferredStyle: .alert)
        
        alert.addTextField { text in
            text.placeholder = "제목을 정해주세요!"
        }
        
        let action = UIAlertAction(title: "확인", style: .default) { _ in
            vc.showTextOverlay("잠시만 기다려주세요!")
            let titleText = (alert.textFields?[0].text)!
            firebaseService().createDB(folderName: titleText, date: date)
            vc.removeAllOverlays()
            vc.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
}
