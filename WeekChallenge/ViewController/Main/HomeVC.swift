//
//  HomeVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/10.
//

import UIKit
import SnapKit
import LSHContributionView

class HomeVC: UIViewController {
    
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var contributionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LSHView()
    }
    
    @IBAction func planChoice(_ sender: Any) {
        /*
         5,10,15일차 할 수 있는 선택지가 나오고
         5일 선택 시,
         1) 5일 챌린지 이름 작성
         2) 현재 날짜와 5일뒤 날짜 자동 기입
         3)
         */
        CustomAlert().createPlan(vc: self, day: "5", date: PlanDate().fiveDate())
    }
    
    func LSHView() {
        let dataSquare = [ [0,1,2,3,4]]
        let contributeView = LSHContributionView(frame: CGRect(x: 0, y: 0, width: contributionView.bounds.width, height: contributionView.bounds.height))
        contributeView.data = dataSquare
        contributeView.colorScheme = "Halloween"
        contributionView.addSubview(contributeView)
    }
}
