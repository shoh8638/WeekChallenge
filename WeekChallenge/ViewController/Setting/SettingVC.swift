//
//  SettingVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/11.

import UIKit
import Firebase
import FirebaseStorage
import SDWebImage
//버튼 지우고, 프로필 및 유저네임 크기 늘리고 -> 버튼 1개 ( 리스트 관리) -> 설정 하단 탭에 추가
class SettingVC: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var settingTable: UITableView!
    
    @IBOutlet weak var imgfirst: UIImageView!
    
    let db = Firestore.firestore()
    var settingTitle = ["프로필 변경","계정 설정","로그아웃","계정삭제"]
    var settingImg = ["","","",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Connectivity().Network(view: self)
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setImg()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func setup() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(imgTap(sender:)))
        self.userImg.addGestureRecognizer(tap)
        self.userImg.isUserInteractionEnabled = true
        
        imgView.layer.cornerRadius = imgView.frame.height / 2
        imgView.layer.masksToBounds = true
        imgView.layer.borderWidth = 1
        imgView.layer.borderColor = CGColor(red: 74, green: 74, blue: 74, alpha: 1)
        
        mainView.layer.cornerRadius = 35
        mainView.layer.masksToBounds = true
        
        setImg()
    }
    
    func setImg() {
        guard let userID = Auth.auth().currentUser?.email  else { return }
        let docRef = db.collection(userID).document("UserData")
        docRef.addSnapshotListener { document, err in
            if err == nil {
                print("ETCVC Success")
                let data = document!.data()
                let username = data!["UserName"] as! String
                if username != "" {
                    self.userName.text = username
                } else {
                    self.userName.text = ""
                }                
                
                if document!["Profile"] as! String != "" {
                    let img = document!["Profile"] as! String
                    Storage.storage().reference(forURL: img).downloadURL { (url, error) in
                        if url != nil {
                            self.userImg.sd_setImage(with: url!, completed: nil)
                        } else {
                            print("HomeVC url err: \(error!)")
                        }
                    }
                } else {
                    
                    self.userImg.image = UIImage(named: "profileIcon")
                    print("ETCVC err")
                }
            }
        }
    }
    
    @objc func imgTap(sender: UIGestureRecognizer) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeProfile") as! HomeProfile
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

extension SettingVC: UITableViewDataSource, UITableViewDelegate {
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SetProfile") as! ProfileVC
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        case 1:
            let alert = UIAlertController(title: "알림", message: "둘 중 하나를 고르시오", preferredStyle: .actionSheet)
            
            let changeNick = UIAlertAction(title: "닉네임 변경", style: .default) { _ in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SetChName") as! ChangeUserNameVC
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
            }
            
            let changePass = UIAlertAction(title: "비밀번호 변경", style: .default) { _ in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SetChPWD") as! ChangePWD
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
            }
            
            alert.addAction(changeNick)
            alert.addAction(changePass)
            self.present(alert, animated: true, completion: nil)
        case 2:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SetLogOut") as! LogOutVC
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        case 3:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SetRemove") as! RemoveVC
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        default:
            print("")
        }
    }
}

class setTableCell: UITableViewCell {
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var arrowBtn: UIButton!
}
