//
//  CountViewModel.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/25.
//

import Foundation

struct CountViewModel {
    var countM: CountModel
    
    func runningCount() -> Int {
        return countM.running!
    }
    
    func completeCount() -> Int {
        return countM.complete!
    }
}
