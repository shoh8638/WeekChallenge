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
    let count = 2
    
    @IBOutlet weak var settingTable: UITableView!
    @IBOutlet weak var userIDText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
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
    
    @IBAction func signOutBtn(_ sender: Any) {
        try? Auth.auth().signOut()
        print("LoginView_SignInBtn")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginView")
        vc?.modalPresentationStyle = .fullScreen
        vc?.modalTransitionStyle = .crossDissolve
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func changePwdBtn(_ sender: Any) {
    }
}

//MARK: TableView Setting
extension SettingVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingTable.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! SettingTableViewCell
        cell.tapBtn.setTitle("안녕", for: .normal)
        return cell
    }
}
