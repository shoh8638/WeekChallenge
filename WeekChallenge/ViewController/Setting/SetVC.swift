//
//  SettingVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/11.

import UIKit
import Firebase
import FirebaseStorage
import SDWebImage

class SetVC: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var dddd: UIView!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var settingTable: UITableView!
    
    var settingTitle = ["프로필 변경","계정 설정","로그아웃","계정삭제"]
    var settingImg = ["","","",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        imgView.layer.cornerRadius = imgView.frame.height / 2
        imgView.layer.masksToBounds = true
        imgView.layer.borderWidth = 1
        imgView.layer.borderColor = CGColor(red: 74, green: 74, blue: 74, alpha: 1)
        
        dddd.layer.cornerRadius = 35
        dddd.layer.masksToBounds = true
    }
    
    func setup() {
        guard let userID = Auth.auth().currentUser?.email  else { return }
        let docRef = db.collection(userID).document("UserData")
        docRef.getDocument { document, err in
            if err == nil {
                print("ETCVC Success")
                let data = document!.data()
                let username = data!["UserName"] as! String
                self.userName.text = username
                
                if document!["Profile"] as! String == "" {
                    self.userImg.image = UIImage(named: "profileIcon")
                } else {
                    let img = document!["Profile"] as! String
                    Storage.storage().reference(forURL: img).downloadURL { (url, error) in
                        self.userImg.sd_setImage(with: url!, completed: nil)
                    }
                }
            } else {
                print("ETCVC err")
            }
        }
    }
}

extension SetVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Setting"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingTable.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! setTableCell
        cell.title.text = settingTitle[indexPath.row]
        return cell
    }
    
    
}

class setTableCell: UITableViewCell {
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var arrowBtn: UIButton!
}
