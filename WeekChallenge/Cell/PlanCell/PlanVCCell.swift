//
//  PlanVCCell.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/17.
//

import UIKit

class PlanVCCell: UICollectionViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var period: UILabel!
    @IBOutlet weak var changeView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        LayoutService().onlyCornerApply(view: backView)
        LayoutService().onlyCornerApply(view: secondView)
        LayoutService().applyListShadow(cell: self)
    }
    
    func update(info: PlanModel, index: Int) {
        title.text = info.title!
        subTitle.text = info.title!
        period.text = "\(info.firstDate!) ~ \(info.lastDate!)"
        changeView.isHidden = false
        ContributeView().LSHViewChange(view: changeView, count: info.complete!)
    }
    
    func emptyUpdate() {
        title.text = "플랜을 생성해주세요!"
        subTitle.text = ""
        period.text = ""
        changeView.isHidden = true
    }
}
