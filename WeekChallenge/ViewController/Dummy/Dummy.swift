//
//  Dummy.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/18.
//

import UIKit

class Dummy: NSObject {
    
//    func initRefresh() {
//        let refresh = UIRefreshControl()
//        refresh.addTarget(self, action: #selector(updateUI(refresh:)), for: .valueChanged)
//        refresh.attributedTitle = NSAttributedString(string: "새로고침")
//        self.listCollection.refreshControl = refresh
//    }
//
//    @objc func updateUI(refresh: UIRefreshControl) {
//        self.dbID.removeAll()
//        self.dbTitles.removeAll()
//        self.dbDate.removeAll()
//        loadData()
//        refresh.endRefreshing()
//    }
}

/*
 func initRefresh() {
     let refresh = UIRefreshControl()
     refresh.addTarget(self, action: #selector(updateUI(refresh:)), for: .valueChanged)
     refresh.attributedTitle = NSAttributedString(string: "새로고침")
     self.listTable.refreshControl = refresh
 }
 
 @objc func updateUI(refresh: UIRefreshControl) {
     self.dbTitles.removeAll()
     self.firstDates.removeAll()
     self.lastDates.removeAll()
     self.eventDates.removeAll()
     loadData()
     refresh.endRefreshing()
 }
 
 
 //
 //  SelectCalendarVC.swift
 //  WeekChallenge
 //
 //  Created by shoh on 2022/03/10.
 //

 import UIKit

 class SelectCalendarVC: UIViewController, UIGestureRecognizerDelegate {
     
     var date: String?
     let lbVM =  ListBtnViewModel()
     var lbM = ListBtnModel()

     
     @IBOutlet weak var backView: UIView!
     @IBOutlet weak var selectCalendar: UITableView!
     
     override func viewDidLoad() {
         super.viewDidLoad()
         ConnectService().Network(view: self)
         ApplyService().onlyCornerApply(view: backView)
         
         let tap = UITapGestureRecognizer(target: self, action: #selector(backTap(sender:)))
         tap.delegate = self
         self.view.addGestureRecognizer(tap)
         loadData()
     }
     
     func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
         self.view.endEditing(true)
         return true
     }
     
     @objc func backTap(sender: UITapGestureRecognizer) {
         print("tap")
         self.dismiss(animated: true, completion: nil)
     }
     
     func loadData() {
         DataService().sLoadData(table: selectCalendar, date: self.date!) { model in
             self.lbM = model
         }
     }
     
     @IBAction func dismissBtn(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
     }
 }
 //MARK: UITableView
 extension SelectCalendarVC: UITableViewDataSource, UITableViewDelegate {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         lbVM.numberOfItem(lbMdel: self.lbM)
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = selectCalendar.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! homeCell
         cell.title.text = lbVM.numberOfTitle(lbModel: lbM, index: indexPath.row)
         cell.periodText.text = lbVM.numberOfPeriod(lbMdel: lbM, index: indexPath.row)
         return cell
     }
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         if self.lbM.titles.count == 0 {
             return self.selectCalendar.frame.height
         } else {
             return self.selectCalendar.frame.height/3
         }
     }
 }

 */
