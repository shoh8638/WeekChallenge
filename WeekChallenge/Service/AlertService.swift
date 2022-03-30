//
//  AlertService.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/14.
//

import UIKit
import SwiftOverlays

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
            DataService().createDB(folderName: titleText, date: date)
            vc.removeAllOverlays()
            vc.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
    
    func basicAlert(viewController: UIViewController, message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func accountAlert(main: UIViewController) {
        let alert = UIAlertController(title: "알림", message: "둘 중 하나를 고르시오", preferredStyle: .actionSheet)
        
        let changeNick = UIAlertAction(title: "닉네임 변경", style: .default) { _ in
            let vc = main.storyboard?.instantiateViewController(withIdentifier: "SetChName") as! ChangeUserNameVC
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            main.present(vc, animated: true, completion: nil)
        }
        
        let changePass = UIAlertAction(title: "비밀번호 변경", style: .default) { _ in
            let vc = main.storyboard?.instantiateViewController(withIdentifier: "SetChPWD") as! ChangePWD
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            main.present(vc, animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .destructive)
        
        alert.addAction(changeNick)
        alert.addAction(changePass)
        alert.addAction(cancel)
        main.present(alert, animated: true, completion: nil)
    }
    
    func updatePlan(view: UIViewController, dbID: String) {
        let alert = UIAlertController(title: "알림", message: "변경할 이름을 정해주세요", preferredStyle: .alert)
        
        alert.addTextField { text in
            text.placeholder = "변경할 이름"
        }
        
        let exitBtn = UIAlertAction(title: "취소", style: .destructive)
        let okBtn = UIAlertAction(title: "확인", style: .default) { _ in
            let newTitle = (alert.textFields?[0].text)!
            DataService().updatePlanName(dbID: dbID, newTitle: newTitle)
            print("DB 플랜 업데이트")
        }
        alert.addAction(exitBtn)
        alert.addAction(okBtn)
        view.present(alert, animated: true)
    }
    
    func deletePlan(view: UIViewController, message: String, dbID: String) {
        let alert = UIAlertController(title: "알림", message: "\(message) 삭제 하시겠습니까?", preferredStyle: .alert)
        
        let exitBtn = UIAlertAction(title: "취소", style: .destructive)
        let okBtn = UIAlertAction(title: "확인", style: .default) { _ in
            DataService().removePlan(dbID: dbID)
            print("DB에서 해당 플랜 삭제")
        }
        alert.addAction(exitBtn)
        alert.addAction(okBtn)
        view.present(alert, animated: true)
    }
}
