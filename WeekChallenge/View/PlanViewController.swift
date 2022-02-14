//
//  PlanViewController.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/14.
//

import UIKit

class PlanViewController: UIViewController {
    let arr: Array<String> = ["1"]
    
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var homeTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        Database().checkDB(userID: "",v: homeView)
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
