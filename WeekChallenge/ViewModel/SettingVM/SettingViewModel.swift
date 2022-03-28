//
//  SettingViewModel.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/28.
//

import Foundation

struct SettingViewModel {
    let settingList: [SettingModel] = [
        SettingModel(title: "프로필 변경"),
        SettingModel(title: "플랜 관리"),
        SettingModel(title: "계정 설정"),
        SettingModel(title: "로그아웃")
    ]
    
    var numberOfList: Int {
        return settingList.count
    }
    
    func numberOfcell(index: Int) -> SettingModel {
        return settingList[index]
    }
}
