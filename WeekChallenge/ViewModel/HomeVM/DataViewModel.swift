//
//  DataViewModel.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/25.
//

import UIKit

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
    
    func numberOfDBID(index: Int) -> String {
        return dataM[index]!.dbID!
    }
    
    func numberOfTitle(index: Int) -> String {
        return dataM[index]!.title!
    }
    
    func heightOfCell(table: UITableView) -> CGFloat {
        if dataM.count == 0 {
            return table.frame.height
        } else {
            return table.frame.height / 4
        }
    }
}
