//
//  SettingModel.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/28.
//

import Foundation
import UIKit

struct SettingModel {
    let title: String
    
    var img: UIImage? {
        return UIImage(named: "\(title).jpg")
    }
    
    init(title: String) {
        self.title = title
    }
}
