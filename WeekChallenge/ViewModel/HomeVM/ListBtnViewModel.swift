//
//  ListBtnViewModel.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/23.
//

import Foundation

class ListBtnViewModel {
    func numberOfItem(lbMdel: ListBtnModel) -> Int {
        return lbMdel.titles.count == 0 ? 1 : lbMdel.titles.count
    }
    
    func numberOfTitle(lbModel: ListBtnModel, index: Int) -> String {
        return lbModel.titles.count == 0 ? "아무것도 없어요" : lbModel.titles[index]
    }
    
    func numberOfPeriod(lbMdel: ListBtnModel, index: Int) -> String {
        return lbMdel.titles.count == 0 ? "" : "\(lbMdel.firstPeriod[index]) ~ \(lbMdel.lastPeriod[index])"
    }
    
    func heightOfCell() {
        
    }
}
