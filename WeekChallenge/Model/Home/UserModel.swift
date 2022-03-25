//
//  UserModel.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/25.
//

import Foundation

struct UserModel {
    let userName: String
    let imgUrl: String
    
    init(userName: String, imgUrl: String) {
        self.userName = userName
        self.imgUrl = imgUrl
    }
}
