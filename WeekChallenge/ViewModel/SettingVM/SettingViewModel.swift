//
//  SettingViewModel.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/24.
//

import Foundation

struct SettingViewModel {
    let sM = SettingModel()
    
    func headerTitle() -> String {
        return sM.setting
    }
    
    func numberOfItem() -> Int {
        return sM.settingTitle.count
    }
    
    func numberOfTitle(index: Int) -> String {
        return sM.settingTitle[index]
    }
    
    func numberofImg(index: Int) -> String {
        return sM.settingImg[index]
    }
}
