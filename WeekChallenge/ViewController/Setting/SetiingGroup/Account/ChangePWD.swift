//
//  ChangePWD.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/16.
//

import UIKit
import SwiftOverlays

class ChangePWD: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var currentPWD: UITextField!
    @IBOutlet weak var changePWD: UITextField!
    @IBOutlet weak var reChangePWD: UITextField!
    @IBOutlet weak var changePWDBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectService().Network(view: self)
        setUp()
    }
    
    func setUp() {
        LayoutService().onlyCornerApply(view: backView)
    }
    
    @IBAction func bakcGes(_ sender: UIGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changePWDBtn(_ sender: Any) {
        self.showTextOverlay("잠시만 기다려주세요")
        DataService().checkPWD(currentPWD: currentPWD.text!) { bool in
            if bool == "false" {
                AlertService().checkAlert(message: "현재 비밀번호가 일치하지 않습니다", vc: self)
                self.removeAllOverlays()
            } else if self.changePWD.text! != self.reChangePWD.text! {
                AlertService().checkAlert(message: "변경 할 비밀번호가 일치하지 않습니다", vc: self)
                self.removeAllOverlays()
            } else {
                DataService().changePWD(changePWD: self.changePWD.text!, vc: self)
                self.removeAllOverlays()
            }
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
