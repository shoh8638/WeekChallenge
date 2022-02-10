//
//  HomeViewController.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/10.
//

import UIKit


class HomeViewController: UIViewController {
    let arr: Array<String> = []
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var homeView: UIView!
    
    lazy var emptyView: EmptyView = {
        let view = EmptyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emptyView.delegate = self
        
        if arr.count == 0 {
            homeView.addSubview(emptyView)
        } else {
        }
    }
}

extension HomeViewController: ButtonAction {
    func touchUpEvent() {
        print("tap")
    }
}
