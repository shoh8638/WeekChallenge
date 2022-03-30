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
        LayoutService().onlyCornerApply(view: backView)
        LayoutService().onlyCornerApply(view: totalView)
        LayoutService().applyDetailListShadow(cell: self)
    }
    
    func update(info: PDetailModel, url: String) {
        mainTitle.text = info.title
        mainText.text = info.text
        PDetailViewModel(pDeatilM: [info]).loadUserImg(url: url, img: imageView)
    }
    
    func emptyUpdate() {
        mainTitle.text = "작성한 글이 없습니다."
        mainText.text = ""
    }
}
