//
//  LogOutVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/15.
//

import UIKit

class LogOutVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var message: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectService().Network(view: self)
        loadData()
    }
    
    
    func loadData() {
        LayoutService().onlyCornerApply(view: mainView)
        DataService().logoutLoadData(message: message)
    }
    
    @IBAction func bakcGes(_ sender: UIGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancleBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okBtn(_ sender: Any) {
        DataService().logout(view: self.view)
    }
}
