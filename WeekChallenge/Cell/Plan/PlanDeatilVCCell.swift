//
//  PlanDetailVCCell.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/24.
//

import UIKit

class PlanDetailVCCell: UICollectionViewCell {
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var mainText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ApplyService().onlyCornerApply(view: backView)
        ApplyService().onlyCornerApply(view: totalView)
        ApplyService().applyDetailListShadow(cell: self)
    }
}
