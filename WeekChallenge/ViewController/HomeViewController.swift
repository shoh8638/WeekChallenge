//
//  HomeViewController.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/10.
//

import UIKit
import SnapKit
import LSHContributionView

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var contributionView: UIView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        LSHView()
    }   
    
    @IBAction func planChoice(_ sender: Any) {
    }
    
    func LSHView() {
        let dataSquare = [ [0,1,2,3,4]]
        let contributeView = LSHContributionView(frame: CGRect(x: 0, y: 0, width: contributionView.bounds.width, height: contributionView.bounds.height))
        contributeView.data = dataSquare
        contributeView.colorScheme = "Halloween"
        contributionView.addSubview(contributeView)
    }
}
