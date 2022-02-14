//
//  PlanViewController.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/14.
//

import UIKit

class PlanViewController: UIViewController {
    let arr: Array<String> = []
    @IBOutlet weak var homeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    lazy var emptyView : EmptyView = {
        let view = EmptyView()
        return view
    }()
    
    func setupView() {
        if arr.count == 0 {
            self.homeView.addSubview(emptyView)
            emptyView.snp.remakeConstraints { maker in
                maker.edges.equalToSuperview()
            }
            self.emptyView.mainButton.addTarget(self, action: #selector(Click), for: .touchUpInside)
        }
    }
    
    @objc func Click(sender: UIButton? = nil) {
        print("Tap")
    }
}

extension PlanViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
