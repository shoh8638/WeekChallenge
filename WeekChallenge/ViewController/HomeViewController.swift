//
//  HomeViewController.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/10.
//

import UIKit
import SnapKit
import SwiftOverlays

class HomeViewController: UIViewController {
    let arr: Array<String> = []
    
    @IBOutlet weak var homeView: UIView!
    
    lazy var emptyView : EmptyView = {
        let view = EmptyView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        self.showTextOverlay("Please Wait...")
        if arr.count == 0 {
            self.removeAllOverlays()
            self.homeView.addSubview(emptyView)
            emptyView.snp.remakeConstraints { maker in
                maker.edges.equalToSuperview()
            }
            self.emptyView.mainButton.addTarget(self, action: #selector(Click), for: .touchUpInside)
        } else {
            self.removeAllOverlays()
        }
    }
    @objc func Click(sender: UIButton? = nil) {
        print("Tap")
    }
}
