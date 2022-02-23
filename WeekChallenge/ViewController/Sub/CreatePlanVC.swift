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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        OneView()
    }
}

//MARK: Button
extension CreatePlanVC {
    @IBAction func fiveDayPlan(_ sender: Any) {
        CustomAlert().createPlan(vc: self, day: "5일", date: PlanDate().fiveDate())
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
}
