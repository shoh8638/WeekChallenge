//
//  ContributeView.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/24.
//

import UIKit
import LSHContributionView

class ContributeView {
    func exampleView(view: UIView) {
        let dataSquare = [[0,0,0,0,0]]
        let contributeView = LSHContributionView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        contributeView.data = dataSquare
        contributeView.colorScheme = "Halloween"
        contributeView.layer.cornerRadius = 15
        contributeView.layer.masksToBounds = true
        contributeView.backgroundColor = UIColor(red: 74, green: 74, blue: 74, alpha: 1)
        view.addSubview(contributeView)
    }
    
    func LSHViewChange(view: UIView, count: Array<Int>) {
        if count != [] {
            let dataSquare = [count]
            let contributeView = LSHContributionView(frame: CGRect(x:0, y: 0, width: view.bounds.width, height: view.bounds.height))
            
            contributeView.data = dataSquare
            contributeView.colorScheme = "Halloween"
            view.addSubview(contributeView)
        }
    }
}
