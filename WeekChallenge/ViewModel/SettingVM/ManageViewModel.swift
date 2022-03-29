//
//  ManageViewModel.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/24.
//

import Foundation

struct ManageViewModel {
    let manageM: [ManageModel?]

    func numberOfRowsInSection() -> Int {
        return manageM.count
    }
    
    func numberOfCellIndex(index: Int) -> ManageModel {
        return manageM[index]!
    }
    
    func numberOfDBID(index: Int) -> String {
        return manageM[index]!.dbID!
    }
    
    func numberOfTitle(index: Int) -> String {
        return manageM[index]!.title!
    }
}
