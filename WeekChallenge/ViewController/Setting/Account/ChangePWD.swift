//
//  ChangePWD.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/16.
//

import UIKit
import Firebase
import FirebaseFirestore
import SwiftOverlays

class ChangePWD: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var currentPWD: UITextField!
    @IBOutlet weak var changePWD: UITextField!
    @IBOutlet weak var reChangePWD: UITextField!
    @IBOutlet weak var changePWDBtn: UIButton!
    
    var complete: String?
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Connectivity().Network(view: self)
        setUp()
    }
    
    func setUp() {
        self.backView.layer.cornerRadius = 20
        self.backView.layer.masksToBounds = true
    }
    
    @IBAction func bakcGes(_ sender: UIGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changePWDBtn(_ sender: Any) {
        self.showTextOverlay("잠시만 기다려주세요")
        checkPWD(currentPWD: currentPWD.text!)
        
        if self.complete == "true" || (changePWD.text! == reChangePWD.text!) {
            Auth.auth().currentUser?.updatePassword(to: changePWD.text!) { error in
                if error == nil {
                    print("ChangePWD Success")
                    guard let userID = Auth.auth().currentUser?.email else { return }
                    let path = self.db.collection(userID).document("UserData")
                    path.updateData(["password": self.changePWD.text!])
                    
                    CustomAlert().checkAlert(message: "비밀번호 변경 성공", vc: self)
                } else {
                    print("ChangePWD Fail")
                    CustomAlert().checkAlert(message: "비밀번호 변경 실패", vc: self)
                }
            }
        } else if self.complete == "false" {
            CustomAlert().checkAlert(message: "현재 비밀번호가 일치하지 않습니다", vc: self)
        } else if changePWD.text! == reChangePWD.text! {
            CustomAlert().checkAlert(message: "변경 할 비밀번호가 일치하지 않습니다", vc: self)
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func checkPWD(currentPWD: String){
        guard let userID = Auth.auth().currentUser?.email else { return }
        Firestore.firestore().collection(userID).document("UserData").getDocument { (document, err) in
            if let err = err {
                print("checkPWD err: \(err)")
            } else {
                let pwd = document!["password"] as! String
                if currentPWD == pwd {
                    self.complete = "true"
                } else {
                    self.complete = "false"
                }
            }
        }
    }
}

extension ChangePWD: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if changePWD.text!.count > 1 && currentPWD.text!.count > 1 && reChangePWD.text!.count > 1{
            self.changePWDBtn.isEnabled = true
            self.changePWDBtn.backgroundColor = UIColor(red: 1.0, green: 22.0/255.0, blue: 84.0/255.0, alpha: 1.0)
        } else {
            self.changePWDBtn.isEnabled = false
            self.changePWDBtn.backgroundColor = .lightGray
        }
        return true
    }
}
