//
//  AccountVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/15.
//

import UIKit
import Firebase

//닉네임, 비밀번호 변경
class AccountVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var nickName: UIButton!
    @IBOutlet weak var pwd: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Connectivity().Network(view: self)
        setUp()
    }
    
    func setUp() {
        self.mainView.layer.cornerRadius = 20
        self.mainView.layer.masksToBounds = true
    }
    
    @IBAction func bakcGes(_ sender: UIGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nickName(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "") as! ChangeUserNameVC
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func pwd(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "") as! ChangePWD
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
