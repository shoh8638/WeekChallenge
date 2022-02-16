//
//  PlanViewController.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/14.
//

import UIKit
import Firebase

class PlanViewController: UIViewController {
    let arr: Array<String> = ["1"]
    var countList: Int?
    
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var homeTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    lazy var emptyView : EmptyView = {
        let view = EmptyView()
        return view
    }()
    
    func setupView() {
        if let userID = Auth.auth().currentUser?.email {
            print(userID)
            Database().checkDB(userID: userID) { count in
                self.countList = count as? Int
                if self.countList! == 1 {
                    self.homeView.addSubview(self.emptyView)
                    self.homeView.backgroundColor = .white
                    self.emptyView.snp.remakeConstraints { maker in
                        maker.edges.equalToSuperview()
                    }
                    self.emptyView.mainButton.addTarget(self, action: #selector(self.emptyClick), for: .touchUpInside)
                    self.homeTable.reloadData()
                }
            }
        }
    }
    @objc func emptyClick(sender: UIButton? = nil) {
        print("Tap")
    }
}

extension PlanViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTable.dequeueReusableCell(withIdentifier: "planView", for: indexPath) as! PlanTableViewCell
        cell.detailBtn.setTitle("Btn", for: .normal)
        return cell
    }
}
