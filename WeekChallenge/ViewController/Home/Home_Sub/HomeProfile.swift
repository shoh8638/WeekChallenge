//
//  HomeProfile.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/11.
//

import UIKit

class HomeProfile: UIViewController, UIGestureRecognizerDelegate {
    
    let applyView = ApplyService()
    var userVM : UserViewModel!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var userImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectService().Network(view: self)
        applyView.onlyCornerApply(view: backView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(backTap(sender:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        
        loadData()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @objc func backTap(sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadData() {
        DataService().userLodaData { model in
            self.userVM = UserViewModel(UserM: model)
            self.userVM.loadUserImg(img: self.userImg)
        }
    }
}
