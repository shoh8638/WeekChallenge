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
    
    let settingVM = SettingViewModel()
    var userVM : UserViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LayoutService().onlyCornerApply(view: mainView)
        LayoutService().imgApplyLayer(img: userImg)
        loadData()
        setUp()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        loadData()
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
        
        let imgTap = UITapGestureRecognizer(target: self, action: #selector(imgTap(sender:)))
        self.userImg.addGestureRecognizer(imgTap)
        self.userImg.isUserInteractionEnabled = true
    }
    
    @objc func xButtonTap(sender: UIGestureRecognizer) {
        print("Tap")
    }
    
    @objc func imgTap(sender: UIGestureRecognizer) {
        ConnectService().sendVC(main: self, name: "HomeProfile")
    }
}

//MARK: UITableView
extension SettingVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Setting"
    }
    
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return settingTable.bounds.height / 4 - 10
    }
}

