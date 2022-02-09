//
//  ServiceViewController.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/09.
//

import UIKit

class ServiceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func changeView(storyBoardName: String) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: storyBoardName)
        vc?.modalPresentationStyle = .fullScreen
        vc?.modalTransitionStyle = .crossDissolve
    }
}
