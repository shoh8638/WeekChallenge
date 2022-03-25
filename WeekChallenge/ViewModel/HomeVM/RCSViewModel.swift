//
//  RCSViewModel.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/25.
//

import Foundation
import UIKit

struct RCSViewModel {
    let rcsM : [RSCModel?]
    
    func numberOfRowInSection() -> Int {
        return rcsM.count
    }
    
    func numberOfCellIndex(index: Int) -> RSCModel {
        return rcsM[index]!
    }
    
    func heightOfCell(table: UITableView) -> CGFloat{
        return rcsM.count == 0 ? table.frame.height : table.frame.height / 3
    }
    
    func selectHeightOfCell(table: UITableView) -> CGFloat {
        return rcsM.count == 1 ? table.frame.height : table.frame.height / 3
    }
}
