//
//  PlanVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/14.
//

import UIKit
import Firebase
import FirebaseFirestore

class PlanVC: UIViewController {
    let arr: Array<String> = ["1"]
    var countList: Int = 0
    
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var homeTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        initRefresh()
    }
    
    lazy var emptyView : EmptyView = {
        let view = EmptyView()
        return view
    }()
    
    func setupView() {
        if let userID = Auth.auth().currentUser?.email {
            print(userID)
            Database().checkDB(userID: userID) { count in
                self.countList = count as! Int
                self.homeTable.reloadData()
            }
        }
    }
    
    @objc func emptyClick(sender: UIButton? = nil) {
        print("PlanView: emptyButton Clcik")
        //createDB부분 추가
    }
    
    //MARK: 새로고침
    func initRefresh() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(updateUI(refresh:)), for: .valueChanged)
        refresh.attributedTitle = NSAttributedString(string: "새로고침")
        
        if #available(iOS 10.0, *) {
            self.homeTable.refreshControl = refresh
        } else {
            self.homeTable.addSubview(refresh)
        }
    }
    
    @objc func updateUI(refresh: UIRefreshControl) {
        setupView()
        refresh.endRefreshing()
    }
}

extension PlanVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countList > 1 ? countList : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTable.dequeueReusableCell(withIdentifier: "planView", for: indexPath) as! PlanTableViewCell
        cell.detailBtn.setTitle("Btn", for: .normal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
}
