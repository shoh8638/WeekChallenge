//
//  EtcVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/16.
//

import UIKit
import Firebase
import FirebaseFirestore

//MARK: 로그아웃, 비밀번호 변경등 기타 화면
class EtcVC: UIViewController {
    
    @IBOutlet weak var userIDText: UILabel!
    @IBOutlet weak var userNickname: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        if let userID = Auth.auth().currentUser?.email {
//            self.userIDText.text = userID
        }
    }
    
    @IBAction func signOutBtn(_ sender: Any) {
        try? Auth.auth().signOut()
    }
    
    @IBAction func changePwdBtn(_ sender: Any) {
        /*
         다른 화면으로 넘어가서 현재 아이디는 id: currentUser?.email 정하고
         pwd: UITextField
         텍스트 필드.텍스트를 넣어서 비밀 번호 변경 하고 로그아웃 되는 화면
         */
    }
}
