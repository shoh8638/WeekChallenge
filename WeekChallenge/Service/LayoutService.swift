//
//  LayoutService.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/23.
//

import Foundation
import UIKit

class LayoutService {
    
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
    
    func buttonCornerApply(btn: UIButton) {
        btn.layer.cornerRadius = btn.layer.frame.size.width / 2
        btn.layer.masksToBounds = true
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 1
    }
    
    func imgApplyLayer(img: UIImageView) {
        img.layer.cornerRadius = img.frame.height / 2
        img.layer.masksToBounds = true
        img.layer.borderWidth = 1
        img.layer.borderColor =  CGColor(red: 74, green: 74, blue: 74, alpha: 1)
    }
    
    func imgOnlyCornerApply(img: UIImageView) {
        img.layer.cornerRadius = 20
        img.layer.masksToBounds = true
    }
    
    func tableApplyLayer(table: UITableView) {
        table.layer.cornerRadius = 20
        table.layer.masksToBounds = false
        table.layer.shadowColor = UIColor.black.cgColor
        table.layer.shadowOpacity = 0.14
        table.layer.shadowOffset = CGSize(width: 10, height: 0)
        table.layer.shadowRadius = 7 / 2.0
    }
    
    func applyListShadow(cell: PlanVCCell) {
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.14
        cell.layer.shadowOffset = CGSize(width: 10, height: 0)
        cell.layer.shadowRadius = 7 / 2.0
    }
    
    
    func applyDetailListShadow(cell: PlanDetailVCCell) {
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.14
        cell.layer.shadowOffset = CGSize(width: 10, height: 0)
        cell.layer.shadowRadius = 7 / 2.0
    }
    
    
    func applyTotalCellShadow(cell: totalCell) {
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.14
        cell.layer.shadowOffset = CGSize(width: 10, height: 0)
        cell.layer.shadowRadius = 7 / 2.0
    }
    
    func applySearchCellShadow(cell: searchCell) {
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.14
        cell.layer.shadowOffset = CGSize(width: 10, height: 0)
        cell.layer.shadowRadius = 7 / 2.0
    }
    
    func applyManageCellShadow(cell: ManageCell) {
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.14
        cell.layer.shadowOffset = CGSize(width: 10, height: 0)
        cell.layer.shadowRadius = 7 / 2.0
    }
    
    func applyHomeCellShadow(cell: HomeCell) {
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
    }
    
    func applytdCellShadow(cell: TotalDetailCell) {
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.14
        cell.layer.shadowOffset = CGSize(width: 10, height: 0)
        cell.layer.shadowRadius = 7 / 2.0
    }
}
