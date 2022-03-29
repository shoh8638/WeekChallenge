//
//  PlanViewModel.swift
//  WeekChallenge
//
//  Created by 오승훈 on 2022/03/25.
//

import Foundation

struct PlanViewModel {
    let planM: [PlanModel?]
    
    func numberOfRowsInSection() -> Int {
        return planM.count
    }
    
    func numberOfCellIndex(index: Int) -> PlanModel {
        return planM[index]!
    }
    
    func numberOfDBID(index: Int) -> String {
        return planM[index]!.dbID!
    }
    
    func numberOfTitle(index: Int) -> String {
        return planM[index]!.title!
    }
    
    func numberOfLSHView(index: Int) -> [Int] {
        return planM[index]!.complete!
    }
}
