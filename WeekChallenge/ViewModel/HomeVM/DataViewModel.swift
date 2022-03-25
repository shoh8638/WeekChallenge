//
//  DataViewModel.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/25.
//

import Foundation

struct DataViewModel {
    let dataM: [DataModel?]
    
    func numberOfRowsInSection() -> Int{
        return dataM.count
    }
    
    func numberOfCellIndex(index: Int) -> DataModel {
        return dataM[index]!
    }
    
    func numberOfEvent(index: Int) -> [String]{
        var dates = [String]()
        for i in 0..<index {
            dates.append(dataM[i]!.firstDate!)
        }
        return dates
    }
}
