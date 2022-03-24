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
    @IBOutlet weak var LSHView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ApplyService().onlyCornerApply(view: backView)
        ApplyService().onlyCornerApply(view: secondView)
        ApplyService().applyListShadow(cell: self)
    }
}