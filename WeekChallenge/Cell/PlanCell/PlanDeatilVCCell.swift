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
    
    func update(info: PDetailModel, index: Int) {
        mainTitle.text = info.title
        mainText.text = info.text
        PDetailViewModel(pDeatilM: [info]).loadUserImg(index: index, img: imageView)
    }
    
    func emptyUpdate() {
        mainTitle.text = "작성한 글이 없습니다."
        mainText.text = ""
    }
}
