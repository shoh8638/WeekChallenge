//
//  CountModel.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/25.
//

import Foundation

struct CountModel {
    let running: Int?
    let complete: Int?
 
    init(running: Int, complete: Int) {
        self.running = running
        self.complete = complete
    }
}
