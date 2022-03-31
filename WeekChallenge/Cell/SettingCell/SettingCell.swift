//
//  SettingCell.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/28.
//

import UIKit

class SettingCell: UITableViewCell {
    @IBOutlet weak var settingTitle: UILabel!
    
 func update(info: SettingModel) {
        settingTitle.text = info.title
        self.layer.cornerRadius = 20
    }
}
