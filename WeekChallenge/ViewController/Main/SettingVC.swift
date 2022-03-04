//
//  SettingVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/16.
//

import UIKit
import Firebase
import FirebaseFirestore

//MARK: 로그아웃, 비밀번호 변경등 기타 화면
class SettingVC: UIViewController {
    
    let db = Firestore.firestore()

    @IBOutlet weak var userIDText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Connectivity().Network(view: self)
        setup()
        self.navigationItem.backBarButtonItem?.isEnabled = true
    }
    
    func setup() {
        if let userID = Auth.auth().currentUser?.email {
            let docRef = db.collection(userID).document("UserData")
            docRef.getDocument { document, err in
                if err == nil {
                    print("ETCVC Success")
                    let data = document!.data()
                    let username = data!["UserName"] as! String
                    self.userIDText.text = username
                } else {
                    print("ETCVC err")
                }
            }
        }
    }

}

//MARK: Button Setting
extension SettingVC {    
    @IBAction func changeUserName(_ sender: Any) {
    }
    
    @IBAction func removeAuth(_ sender: Any) {
    }
    
    @IBAction func changePwdBtn(_ sender: Any) {
    }
    
    @IBAction func signOutBtn(_ sender: Any) {
//        try? Auth.auth().signOut()
//        print("LoginView_SignInBtn")
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginView")
//        self.present(vc!, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logout" {
            try? Auth.auth().signOut()
            print("LoginView_SignInBtn")
        }
    }

}
