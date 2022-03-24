//
//  ManageListViewModel.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/24.
//

import Foundation

struct ManageListViewModel {
    func numberOfItems(mlM: ManageListModel) -> Int {
        return mlM.dbID.count == 0 ? 1 : mlM.dbID.count
    }
    
    func numberOfTitles(mlM: ManageListModel, index: Int) -> String {
        return mlM.dbID.count == 0 ? "생성된 플랜이 없습니다." : mlM.titles[index]
    }
    
    func numberOfDates(mlM: ManageListModel, index: Int) -> String {
        return mlM.dbID.count == 0 ? "" : "\(mlM.firstDates[index]) ~ \(mlM.lastDates[index])"
    }
    
    func numberOfID(mlM: ManageListModel, index: Int) -> String{
        return mlM.dbID[index]
    }
}
