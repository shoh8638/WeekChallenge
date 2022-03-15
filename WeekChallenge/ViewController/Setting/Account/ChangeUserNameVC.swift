//
//  ChangeUserNameVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/15.
//

import UIKit
import Firebase
import SwiftOverlays

class ChangeUserNameVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var reChangeNick: UITextField!
    @IBOutlet weak var chageNickBtn: UIButton!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp() {
        self.mainView.layer.cornerRadius = 20
        self.mainView.layer.masksToBounds = true
    }
    @IBAction func bakcGes(_ sender: UIGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func chageNickBtn(_ sender: Any) {
        self.showTextOverlay("잠시만 기다려주세요")
        if self.reChangeNick.text!.count > 1 {
            guard let userID = Auth.auth().currentUser?.email else { return }
            let path = self.db.collection(userID).document("UserData")

            path.updateData(["UserName": self.reChangeNick.text!])
            print("Change Nick")
            self.removeAllOverlays()
            self.dismiss(animated: true)
        } else {
            let alert = UIAlertController(title: "알림", message: "비밀번호를 입력해주세요", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension ChangeUserNameVC: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if self.reChangeNick.text!.count > 1{
            self.chageNickBtn.isEnabled = true
            self.chageNickBtn.backgroundColor = UIColor(red: 1.0, green: 22.0/255.0, blue: 84.0/255.0, alpha: 1.0)
        } else {
            self.chageNickBtn.isEnabled = false
            self.chageNickBtn.backgroundColor = .lightGray
        }
        return true
    }
}
