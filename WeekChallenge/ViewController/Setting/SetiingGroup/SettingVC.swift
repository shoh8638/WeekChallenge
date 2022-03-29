//
//  SettingVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/28.
//

import UIKit

class SettingVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var settingCollection: UICollectionView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    let settingVM = SettingViewModel()
    var userVM : UserViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ApplyService().onlyCornerApply(view: mainView)
        ApplyService().imgApplyLayer(img: userImg)
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

//MARK: UICollectionView
extension SettingVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingVM.numberOfList
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = settingCollection.dequeueReusableCell(withReuseIdentifier: "settingCell", for: indexPath) as! SettingCell
        let data = settingVM.numberOfcell(index: indexPath.row)
        cell.update(info: data)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (settingCollection.frame.width / 2) - 22, height: (settingCollection.frame.height / 2 - 12))
    }
}
