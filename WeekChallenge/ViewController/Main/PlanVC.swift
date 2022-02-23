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
        checkDBList()
        initRefresh()
    }
    
//    lazy var emptyView : EmptyView = {
//        let view = EmptyView()
//        return view
//    }()
//    @objc func emptyClick(sender: UIButton? = nil) {
//        print("PlanView: emptyButton Clcik")
//    }
    
    func checkDBList() {
        if let userID = Auth.auth().currentUser?.email {
            Database().checkDB(userID: userID) { count in
                self.countList = count as! Int
                self.homeTable.reloadData()
            }
        }
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
        checkDBList()
        refresh.endRefreshing()
    }
}

//MARK: Table DataSource, Delegate
extension PlanVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countList == 1 ? 1 : countList-1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if countList == 1 {
            let cell = homeTable.dequeueReusableCell(withIdentifier: "emptyView", for: indexPath) as! EnptyTableViewCell
            cell.vc = self
            return cell
        } else {
            let cell = homeTable.dequeueReusableCell(withIdentifier: "planView", for: indexPath) as! PlanTableViewCell
            cell.detailBtn.setTitle("Btn", for: .normal)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if countList == 1 {
            return homeTable.bounds.height
        } else {
            return UIScreen.main.bounds.height / 4 - 10
        }
    }
}
