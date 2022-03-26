//
//  TotalCell.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/24.
//

import UIKit

class totalCell: UICollectionViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var text: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ApplyService().onlyCornerApply(view: self.contentView)
        ApplyService().imgOnlyCornerApply(img: img)
        ApplyService().applyTotalCellShadow(cell: self)
    }
}
