//
//  HomeViewController.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/10.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    let arr: Array<String> = []
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var homeView: UIView!
    
    let emptyView = EmptyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        emptyView.delegate = self
        emptyView.snp.remakeConstraints { maker in
            maker.width.equalTo(UIScreen.main.bounds.width)
            maker.height.equalTo(UIScreen.main.bounds.height)
        }
        if arr.count == 0 {
            self.homeView.addSubview(emptyView)
        } else {
            
        }
    }
}

extension HomeViewController: ButtonAction {
    func touchUpEvent() {
        print("tap")
    }
}
