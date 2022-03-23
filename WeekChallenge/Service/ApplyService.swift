//
//  ApplyService.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/23.
//

import Foundation
import UIKit

class ApplyService {
    
    func onlyCornerApply(view: UIView) {
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
    }
    
    func viewApplyLayer(view: UIView) {
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.14
        view.layer.shadowOffset = CGSize(width: 10, height: 0)
        view.layer.shadowRadius = 7 / 2.0
    }
    
    func buttonApplyLayer(btn: UIButton) {
        btn.layer.cornerRadius = 15
        btn.layer.borderWidth = 1
        btn.layer.borderColor = CGColor(red: 74, green: 74, blue: 74, alpha: 1)
        btn.layer.masksToBounds = false
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.14
        btn.layer.shadowOffset = CGSize(width: 8, height: 0)
        btn.layer.shadowRadius = 7 / 2.0
    }
    
    func imgApplyLayer(img: UIImageView) {
        img.layer.cornerRadius = img.frame.height / 2
        img.layer.masksToBounds = true
        img.layer.borderWidth = 1
        img.layer.borderColor =  CGColor(red: 74, green: 74, blue: 74, alpha: 1)
    }
    
    func tableApplyLayer(table: UITableView) {
        table.layer.cornerRadius = 20
        table.layer.masksToBounds = false
        table.layer.shadowColor = UIColor.black.cgColor
        table.layer.shadowOpacity = 0.14
        table.layer.shadowOffset = CGSize(width: 10, height: 0)
        table.layer.shadowRadius = 7 / 2.0
    }
}
