//
//  CreatePlanVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/16.
//

import UIKit
import Firebase
import SwiftOverlays
import LSHContributionView

class CreatePlanVC: UIViewController {
    
    @IBOutlet weak var fiveView: UIView!
    @IBOutlet weak var tenView: UIView!
    @IBOutlet weak var fifteenView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        OneView()
        TwoView()
        ThreeView()
    }
}

//MARK: Button
extension CreatePlanVC {
    @IBAction func fiveDayPlan(_ sender: Any) {
        CustomAlert().createPlan(vc: self, day: "5일", date: PlanDate().fiveDate())
    }
    
    @IBAction func tenDayPlan(_ sender: Any) {
        CustomAlert().createPlan(vc: self, day: "10일", date: PlanDate().tenDate())
    }
    
    @IBAction func fifteenDayPlan(_ sender: Any) {
        CustomAlert().createPlan(vc: self, day: "15일", date: PlanDate().fifteenDate())
    }
}

//MARK: View Update
extension CreatePlanVC {
    func OneView() {
        let dataSquare = [ [0,1,2,3,4]]
        let contributeView = LSHContributionView(frame: CGRect(x: 0, y: 0, width: fiveView.bounds.width, height: fiveView.bounds.height))
        contributeView.data = dataSquare
        contributeView.colorScheme = "Halloween"
        fiveView.addSubview(contributeView)
    }
    
    func TwoView() {
        let dataSquare = [ [0,1,2,3,4],
                           [0,1,2,3,4]]
        let contributeView = LSHContributionView(frame: CGRect(x: 0, y: 0, width: tenView.bounds.width, height: tenView.bounds.height))
        contributeView.data = dataSquare
        contributeView.colorScheme = "Halloween"
        tenView.addSubview(contributeView)
    }
    
    func ThreeView() {
        let dataSquare = [ [0,1,2,3,4],
                           [0,1,2,3,4],
                           [0,1,2,3,4]]
        let contributeView = LSHContributionView(frame: CGRect(x: 0, y: 0, width: fifteenView.bounds.width, height: fifteenView.bounds.height))
        contributeView.data = dataSquare
        contributeView.colorScheme = "Halloween"
        fifteenView.addSubview(contributeView)
    }
}
