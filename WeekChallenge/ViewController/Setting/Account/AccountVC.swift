//
//  AccountVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/15.
//

import UIKit

class AccountVC: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var nickName: UIButton!
    @IBOutlet weak var pwd: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectService().Network(view: self)
        setUp()
    }
    
    func setUp() {
        ApplyService().onlyCornerApply(view: mainView)
    }
    
    @IBAction func bakcGes(_ sender: UIGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nickName(_ sender: Any) {
        ConnectService().sendVC(main: self, name: "SetChName")
    }
    
    @IBAction func pwd(_ sender: Any) {
        ConnectService().sendVC(main: self, name: "SetChPWD")
    }
}
