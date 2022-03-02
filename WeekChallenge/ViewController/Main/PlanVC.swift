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
    var dbDate: Array<Array<Int>> =  []
    var dbID = [String]()
    
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var homeTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        initRefresh()
    }
    
    func loadData() {
        var complete = [Int]()
        guard let userID = Auth.auth().currentUser?.email else {return}
        Database().checkDB(userID: userID) { count in
            self.countList = count as! Int
        }
        self.db.collection(userID).getDocuments { (querySnapshot, err) in
            if err == nil {
                for document in querySnapshot!.documents {
                    if document.documentID != "UserData" {
                        self.dbID.append(document.documentID)
                        let range = document.documentID.firstIndex(of: "+") ?? document.documentID.endIndex
                        self.dbTitles.append(String(document.documentID[..<range]))
                        
                        let dates = (document["Dates"] as! [String]).sorted(by: <)
                        for number in 0...dates.count-1 {
                            let dateFields = document[dates[number]] as! [String: String]
                            let text = dateFields["Text"]!
                            if text == "" {
                                complete.append(0)
                            } else {
                                complete.append(1)
                            }
                        }
                        self.dbDate.append(complete)
                        complete.removeAll()
                    }
                }
            }
            self.homeTable.reloadData()
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
    self.dbID.removeAll()
    self.dbTitles.removeAll()
    self.dbDate.removeAll()
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
        if countList == 1 {
            return 1
        } else if !self.dbTitles.isEmpty {
            return self.dbTitles.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if countList == 1 {
            let cell = homeTable.dequeueReusableCell(withIdentifier: "emptyView", for: indexPath) as! EnptyTableViewCell
            cell.vc = self
            return cell
        } else {
            let cell = homeTable.dequeueReusableCell(withIdentifier: "planView", for: indexPath) as! PlanTableViewCell
            cell.detailBtn.setTitle(dbTitles[indexPath.row], for: .normal)
            cell.detailBtn.tag = indexPath.row
            LSHView(view: cell.planView, count: self.dbDate[indexPath.row])
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "write" {
            guard let writeVC = segue.destination as? WriteVC else { return }
            writeVC.documentID = self.dbID[(sender as? UIButton)!.tag]
        }
    }
    func LSHView(view: UIView, count: Array<Int>) {
        if count != [] {
            let dataSquare = [count]
            let contributeView = LSHContributionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: view.bounds.height))
            contributeView.data = dataSquare
            contributeView.colorScheme = "Halloween"
            view.addSubview(contributeView)
        }
    }
}
