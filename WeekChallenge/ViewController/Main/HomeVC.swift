//
//  HomeVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/10.
//

import UIKit
import Firebase
import FSCalendar

class HomeVC: UIViewController {
    
    let db = Firestore.firestore()
    var dbTitles = [String]()
    var firstDates = [String]()
    var lastDates = [String]()
    var eventDates = [[String]]()
    
    @IBOutlet weak var wecolmeText: UILabel!
    @IBOutlet weak var calendarHeight: NSLayoutConstraint!
    @IBOutlet weak var fsCalender: FSCalendar!
    @IBOutlet weak var homeTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Connectivity().Network(view: self)
        checkUser()
        loadData()
        initRefresh()
        calendarSetip()
        swipe()
    }
    
    func checkUser() {
        guard let userID = Auth.auth().currentUser?.email else { return }
        Database().checkDB(userID: userID) { count in
            let num = count as! Int
            if num > 1 {
                self.wecolmeText.text = "현재 \(num-1)개 플랜이 실행중입니다!"
            } else {
                self.wecolmeText.text = "버튼을 눌러 플랜을 생성해주세요!"
            }
        }
    }
    
    func loadData() {
        guard let userID = Auth.auth().currentUser?.email else { return }
        self.db.collection(userID).addSnapshotListener {(querySnapshot, err) in
            self.dbTitles.removeAll()
            self.firstDates.removeAll()
            self.lastDates.removeAll()
            self.eventDates.removeAll()
            self.fsCalender.reloadData()
            if err == nil {
                for document in querySnapshot!.documents {
                    if document.documentID != "UserData" {
                        self.dbTitles.append(document.data()["Title"] as! String)
                        
                        let first = (document["Dates"] as! [String]).sorted(by: <).first!
                        let last = (document["Dates"] as! [String]).sorted(by: <).last!
                        let event = (document["Dates"] as! [String]).sorted(by: <)
                        self.firstDates.append(first)
                        self.lastDates.append(last)
                        self.eventDates.append(event)
                    }
                }
            }
            self.homeTable.reloadData()
        }
    }
    
    func initRefresh() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(updateUI(refresh:)), for: .valueChanged)
        refresh.attributedTitle = NSAttributedString(string: "새로고침")
        self.homeTable.refreshControl = refresh
    }
    
    @objc func updateUI(refresh: UIRefreshControl) {
        self.dbTitles.removeAll()
        self.firstDates.removeAll()
        self.lastDates.removeAll()
        self.eventDates.removeAll()
        loadData()
        refresh.endRefreshing()
    }
    
    @IBAction func settingButton(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppSetting") as! SettingVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

//MARK: FSCalendar관련
extension HomeVC: FSCalendarDelegate, FSCalendarDataSource {
    func calendarSetip() {
        self.fsCalender.dataSource = self
        self.fsCalender.delegate = self
        fsCalender.scope = .week
        fsCalender.locale = Locale(identifier: "ko_KR")
    }
    
    func swipe() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeEvent(_:)))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeEvent(_:)))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    @objc func swipeEvent(_ swipe: UISwipeGestureRecognizer) {
        
        if swipe.direction == .up {
            fsCalender.scope = .week
        }
        else if swipe.direction == .down {
            fsCalender.scope = .month
        }
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        if calendar.scope == .week {
            calendarHeight.constant = bounds.height
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
        else if calendar.scope == .month {
            calendarHeight.constant = self.view.bounds.height / 4
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateFomatter = DateFormatter()
        dateFomatter.dateFormat = "yyyy-MM-dd"
        let day = dateFomatter.string(from: date)
        if self.firstDates.contains(day) {
            return 1
        } else if self.lastDates.contains(day) {
            return 1
        } else {
            return 0
        }
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        let eventScaleFactor: CGFloat = 2.0
        cell.eventIndicator.transform = CGAffineTransform(scaleX: eventScaleFactor, y: eventScaleFactor)
    }
}

//MARK: UITableView
extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.dbTitles.count == 0 {
            return 1
        } else {
            return self.dbTitles.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.dbTitles.count == 0 {
            let cell = homeTable.dequeueReusableCell(withIdentifier: "homeEmptyCell", for: indexPath) as! homeEmptyCell
            cell.title.text = "아무것도 없어요"
            cell.periodText.text = "아무것도 없어요"
            return cell
        } else {
            let cell = homeTable.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! homeCell
            cell.title.text = self.dbTitles[indexPath.row]
            cell.periodText.text = "\(self.firstDates[indexPath.row]) ~ \(self.lastDates[indexPath.row])"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.dbTitles.count == 0 {
            return self.homeTable.frame.height
        } else {
            return self.homeTable.frame.height/3
        }
    }
}


class homeCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var periodText: UILabel!
}

class homeEmptyCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var periodText: UILabel!
}
