//
//  SettingCell.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/28.
//

import UIKit

class SettingCell: UICollectionViewCell {
    @IBOutlet weak var settingTitle: UILabel!
    @IBOutlet weak var nameView: UIView!
    
 func update(info: SettingModel) {
        contentView.layer.cornerRadius = 20
        settingTitle.text = info.title
        self.layer.cornerRadius = 20
        nameView.layer.cornerRadius = 20
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.14
        self.layer.shadowOffset = CGSize(width: 10, height: 0)
        self.layer.shadowRadius = 7 / 2.0
    }
}
