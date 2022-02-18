//
//  PlanVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/14.
//

import UIKit
import Firebase

class PlanVC: UIViewController {
    let arr: Array<String> = ["1"]
    var countList: Int = 0
    
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
                self.countList = count as! Int
                if self.countList == 1 {
                    self.homeView.addSubview(self.emptyView)
                    self.homeView.backgroundColor = .white
                    self.emptyView.snp.remakeConstraints { maker in
                        maker.edges.equalTo(UIEdgeInsets(top: 200, left: 50, bottom: 200, right: 50))
                    }
                    self.emptyView.mainButton.addTarget(self, action: #selector(self.emptyClick), for: .touchUpInside)
                    self.homeTable.reloadData()
                }
            }
        }
    }
    
    @objc func emptyClick(sender: UIButton? = nil) {
        print("emptyButton Clcik")
        //5,10,15일 추가화면으로 전환 위로 뜨기
    }
}

extension PlanVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countList > 1 ? countList : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTable.dequeueReusableCell(withIdentifier: "planView", for: indexPath) as! PlanTableViewCell
        cell.detailBtn.setTitle("Btn", for: .normal)
        return cell
    }
    
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
        refresh.endRefreshing()
        self.homeTable.reloadData()
    }
}
