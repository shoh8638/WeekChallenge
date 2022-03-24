//
//  PlanDetailViewModel.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/24.
//

import Foundation

struct PlanDetailViewModel {
    func numberOfItem(pDeatilM: PlanDetailModel) -> Int {
        return pDeatilM.subTitles.count == 0 ? 1 : pDeatilM.subTitles.count
    }
    
    func numberOfTitle(pDeatilM: PlanDetailModel, index: Int) -> String {
        return pDeatilM.subTitles.count == 0 ? "정보가 없습니다." : pDeatilM.subTitles[index]
    }
    
    func numberOfSubTitle(pDeatilM: PlanDetailModel, index: Int) -> String {
        return pDeatilM.subText.count == 0 ? "" : pDeatilM.subText[index]
    }
    
    func numberOfImg(pDeatilM: PlanDetailModel, index: Int) -> String {
        return pDeatilM.subImg.count == 0 ? "" : pDeatilM.subImg[index]
    }
}
