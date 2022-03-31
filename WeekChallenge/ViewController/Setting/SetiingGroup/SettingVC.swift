//
//  SettingVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/28.
//

import UIKit

class SettingVC: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var settingTable: UITableView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var imgW: NSLayoutConstraint!
    @IBOutlet weak var imgH: NSLayoutConstraint!
    let settingVM = SettingViewModel()
    var userVM : UserViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let a = UIScreen.main.bounds.width / 2.5
        let b = UIScreen.main.bounds.height / 4
        imgW.constant = a
        imgH.constant = b
        print(a)
        print(b)
        LayoutService().onlyCornerApply(view: mainView)
//        LayoutService().imgApplyLayer(img: userImg)
        userImg.layer.cornerRadius = 20
        userImg.layer.masksToBounds = true
        loadData()
        setUp()
    }
    
    func loadData() {
        DataService().userLodaData { model in
            self.userVM = UserViewModel(UserM: model)
            self.userName.text = "Hello! \(self.userVM.loadUserName())"
            self.userVM.loadUserImg(img: self.userImg)
        }
    }
    
    func setUp() {
        let tap = UIGestureRecognizer(target: self, action: #selector(xButtonTap(sender:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        self.view.isUserInteractionEnabled = true
    }
    
    @objc func xButtonTap(sender: UIGestureRecognizer) {
        print("Tap")
    }
    
}

//MARK: UITableView
extension SettingVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingVM.numberOfList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = settingTable.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! SettingCell
        let data = settingVM.numberOfcell(index: indexPath.row)
        cell.update(info: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            ConnectService().sendVC(main: self, name: "SetProfile")
        case 1:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SetList")
            self.present(vc!, animated: true)
        case 2:
            AlertService().accountAlert(main: self)
        case 3:
            ConnectService().sendVC(main: self, name: "SetLogOut")
        default:
            print("")
        }
    }
}

