//
//  PDetailModel.swift
//  WeekChallenge
//
//  Created by 오승훈 on 2022/03/25.
//

import Foundation

struct PDetailModel {
    let title: String
    let img: String
    let text: String
    
    init(title: String, img: String, text: String) {
        self.title = title
        self.img = img
        self.text = text
    }
}
