//
//  TotalDetailVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/04/06.
//

import UIKit

class TotalDetailCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var userTitle: UILabel!
    @IBOutlet weak var userText: UILabel!
    
    func update(info: TotalDeatilModel) {
        userTitle.text = info.userTitle
        userText.text = info.userText
        TotalDetailViewModel(tDetailM: info).loadUserImg(img: self.img)
        LayoutService().applytdCellShadow(cell: self)
    }
}
