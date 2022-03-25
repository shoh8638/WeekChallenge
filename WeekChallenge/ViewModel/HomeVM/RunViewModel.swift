//
//  RunViewModel.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/25.
//

import Foundation
import UIKit

struct RunViewModel {
    let runM : [RunModel?]
    
    func numberOfRowInSection() -> Int {
        return runM.count
    }
    
    func numberOfCellIndex(index: Int) -> RunModel {
        return runM[index]!
    }
    
    func heightOfCell(table: UITableView) -> CGFloat{
        return runM.count == 0 ? table.frame.height : table.frame.height / 3
    }
}
