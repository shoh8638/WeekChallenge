//
//  DashBoardViewModel.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/24.
//

import Foundation

struct DashBoardViewModel {
    func numberOfItem(dbM: DashBoardModel) -> Int {
        return dbM.userImg.count == 0 ? 1 : dbM.userImg.count
    }
    
    func numberOfImg(dbM: DashBoardModel, index: Int) -> String {
        return dbM.userImg.count == 0 ? "" : dbM.userImg[index]
    }
    
    func numberOfTitle(dbM: DashBoardModel, index: Int) -> String {
        return dbM.userTitles.count == 0 ? "" : dbM.userTitles[index]
    }
    
    func numberOfText(dbM: DashBoardModel, index: Int) -> String {
        return dbM.userText.count == 0 ? "" : dbM.userText[index]
    }
}
