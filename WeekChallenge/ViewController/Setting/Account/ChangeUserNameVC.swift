//
//  ChangeUserNameVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/15.
//

import UIKit
import SwiftOverlays

class ChangeUserNameVC: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var reChangeNick: UITextField!
    @IBOutlet weak var chageNickBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp() {
        ApplyService().onlyCornerApply(view: mainView)
    }
    @IBAction func bakcGes(_ sender: UIGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func chageNickBtn(_ sender: Any) {
        showTextOverlay("잠시만 기다려주세요")
        if reChangeNick.text!.count > 1 {
            DataService().changeNick(reChangeNick: reChangeNick.text!)
            self.removeAllOverlays()
            self.dismiss(animated: true)
        } else {
            AlertService().basicAlert(viewController: self, message: "비밀번호를 입력해주세요")
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
