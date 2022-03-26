//
//  TotalModel.swift
//  WeekChallenge
//
//  Created by 오승훈 on 2022/03/26.
//

import Foundation

struct TotalModel {
    let dbID: String
    let title: String
    let userTitle: String
    let userImg: String
    let userText: String
    
    init(dbID: String, title: String, userTitle: String, userImg: String, userText: String) {
        self.dbID = dbID
        self.title = title
        self.userTitle = userTitle
        self.userImg = userImg
        self.userText = userText
    }
}
