//
//  PlanDate.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/16.
//

import UIKit

class PlanDate {
    func fiveDate() -> [String: String] {
        let fomatter = DateFormatter()
        fomatter.dateFormat = "yyy-MM-dd"
        let currentData = Date()
        var fiveDateFomtter: [String: String] = [:]
        
        for i in 0...4 {
            let date1 = fomatter.string(from: Calendar.current.date(byAdding: .day, value: i, to: currentData)!)
            fiveDateFomtter.updateValue("", forKey: date1)
        }
        return fiveDateFomtter
    }
    
    func tenDate() -> [String: String] {
        let fomatter = DateFormatter()
        fomatter.dateFormat = "yyy-MM-dd"
        let currentData = Date()
        var tenDateFomtter: [String: String] = [:]
        
        for i in 0...9 {
            let date1 = fomatter.string(from: Calendar.current.date(byAdding: .day, value: i, to: currentData)!)
            tenDateFomtter.updateValue("", forKey: date1)
        }
        return tenDateFomtter
    }

    func fifteenDate() -> [String: String] {
        let fomatter = DateFormatter()
        fomatter.dateFormat = "yyy-MM-dd"
        let currentData = Date()
        var fifteenDateFomtter: [String: String] = [:]
        
        for i in 0...14 {
            let date1 = fomatter.string(from: Calendar.current.date(byAdding: .day, value: i, to: currentData)!)
            fifteenDateFomtter.updateValue("", forKey: date1)
        }
        return fifteenDateFomtter
    }
}
