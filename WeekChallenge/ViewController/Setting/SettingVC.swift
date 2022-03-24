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
    let sVM = SettingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectService().Network(view: self)
        setup()
        loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        loadData()
    }
    
    func setup() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(imgTap(sender:)))
        self.userImg.addGestureRecognizer(tap)
        self.userImg.isUserInteractionEnabled = true
        
        ApplyService().imgApplyLayer(img: imgView)
        ApplyService().onlyCornerApply(view: mainView)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @objc func imgTap(sender: UIGestureRecognizer) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeProfile") as! HomeProfile
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func loadData() {
        DataService().settingLoadData(userName: userName, userImg: userImg)
    }
}

extension SettingVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sVM.headerTitle()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sVM.numberOfItem()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingTable.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! setTableCell
        cell.title.text = sVM.numberOfTitle(index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            ConnectService().sendVC(main: self, name: "SetProfile")
        case 1:
            AlertService().accountAlert(main: self)
        case 2:
            ConnectService().sendVC(main: self, name: "SetLogOut")
        case 3:
            ConnectService().sendVC(main: self, name: "SetRemove")
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
