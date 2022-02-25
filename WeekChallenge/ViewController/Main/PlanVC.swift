//
//  PlanVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/14.
//

import UIKit
import Firebase
import LSHContributionView

class PlanVC: UIViewController {
    var countList: Int = 0
    let db = Firestore.firestore()
    var dbTitles: Array<String> = []
    var dbA: Array<String> = []
    
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var homeTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        initRefresh()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("PlanVC_reloadData")
        loadData()
    }
    
    func loadData() {
        if let userID = Auth.auth().currentUser?.email {
            Database().checkDB(userID: userID) { count in
                self.countList = count as! Int
                self.db.collection(userID).getDocuments { (querySnapshot, err) in
                    if err == nil {
                        for document in querySnapshot!.documents {
                            if document.documentID != "UserData"{
                                let dbTitle = document.data()["Title"] as! String
                                self.dbTitles.append(dbTitle)
                                let list = Set(self.dbTitles)
                                self.dbTitles = Array(list).sorted(by: >)
                                //Todo: date == "" ? Array<Int>.append(0) : Array<Int>.append(1) -> LSHView dataSource 채우기
                            }
                            self.homeTable.reloadData()
                        }
                    }
                }
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
        loadData()
        refresh.endRefreshing()
    }
    
    @IBAction func settingButton(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppSetting") as! SettingVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

//MARK: Table DataSource, Delegate
extension PlanVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countList == 1 ? 1 : dbTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if countList == 1 {
            let cell = homeTable.dequeueReusableCell(withIdentifier: "emptyView", for: indexPath) as! EnptyTableViewCell
            cell.vc = self
            return cell
        } else {
            let cell = homeTable.dequeueReusableCell(withIdentifier: "planView", for: indexPath) as! PlanTableViewCell
            cell.detailBtn.setTitle(dbTitles[indexPath.row], for: .normal)
            LSHView(view: cell.planView)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if countList == 1 {
            return homeTable.bounds.height
        } else {
            return UIScreen.main.bounds.height / 5
        }
    }
    
    func LSHView(view: UIView) {
        let dataSquare = [[0,1,2,3,4]]
        let contributeView = LSHContributionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: view.bounds.height))
        contributeView.data = dataSquare
        contributeView.colorScheme = "Halloween"
        view.addSubview(contributeView)
    }
}
