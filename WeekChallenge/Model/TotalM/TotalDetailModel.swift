//
//  TotalDeatilModel.swift
//  WeekChallenge
//
//  Created by shoh on 2022/04/06.
//

import Foundation

struct TotalDeatilModel {
    let userTitle: String
    let userImg: String
    let userText: String
    
    init(userTitle: String, userImg: String, userText: String) {
        self.userTitle = userTitle
        self.userImg = userImg
        self.userText = userText
    }
}
