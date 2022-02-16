//
//  PlanDate.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/16.
//

import UIKit

class PlanDate {
    func fiveDate() -> [String] {
        let fomatter = DateFormatter()
        fomatter.dateFormat = "yyy-MM-dd"
        let currentData = Date()
        var fiveDateFomtter: Array<String> = []
        
        for i in 0...4 {
            let date1 = fomatter.string(from: Calendar.current.date(byAdding: .day, value: i, to: currentData)!)
            fiveDateFomtter.append(date1)
        }
        return fiveDateFomtter
    }
    
    func tenDate() -> [String] {
        let fomatter = DateFormatter()
        fomatter.dateFormat = "yyy-MM-dd"
        let currentData = Date()
        var tenDateFomtter: Array<String> = []
        
        for i in 0...9 {
            let date1 = fomatter.string(from: Calendar.current.date(byAdding: .day, value: i, to: currentData)!)
            tenDateFomtter.append(date1)
        }
        return tenDateFomtter
    }

    func fifteenDate() -> [String] {
        let fomatter = DateFormatter()
        fomatter.dateFormat = "yyy-MM-dd"
        let currentData = Date()
        var fifteenDateFomtter: Array<String> = []
        
        for i in 0...14 {
            let date1 = fomatter.string(from: Calendar.current.date(byAdding: .day, value: i, to: currentData)!)
            fifteenDateFomtter.append(date1)
        }
        return fifteenDateFomtter
    }
}
