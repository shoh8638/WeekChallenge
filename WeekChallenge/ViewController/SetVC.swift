//
//  SettingVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/11.
//

import UIKit

class SetVC: UIViewController {
    
    @IBOutlet weak var imgBackView: UIView!
    @IBOutlet weak var dddd: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgBackView.layer.cornerRadius = 20
        imgBackView.layer.masksToBounds = true
        
        dddd.layer.cornerRadius = 20
        dddd.layer.masksToBounds = true
    }

}
