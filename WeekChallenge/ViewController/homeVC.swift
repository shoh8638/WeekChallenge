//
//  homeVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/10.
//

import UIKit
import Firebase
import FSCalendar

class homeVC: UIViewController {

    let db = Firestore.firestore()
    var dbID = [String]()
    var dbTitles = [String]()
    var firstDates = [String]()
    var lastDates = [String]()
    var eventDates = [[String]]()
    var dbDate = [[Int]]()
    var runningCount = 0
    var completeCount = 0
    
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var completeBtn: UIButton!
    @IBOutlet weak var runningBtn: UIButton!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarHeight: NSLayoutConstraint!
    @IBOutlet weak var listTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadData()
        initRefresh()
    }
    
    func setupView() {
        self.userView.layer.cornerRadius = 20
        self.userView.layer.masksToBounds = true
        self.addBtn.layer.cornerRadius = 15
        self.addBtn.layer.masksToBounds = true
        self.addBtn.layer.borderWidth = 1
        self.addBtn.layer.borderColor = CGColor(red: 74, green: 74, blue: 74, alpha: 1)
        
        self.runningBtn.layer.cornerRadius = 15
        self.runningBtn.layer.masksToBounds = true
        self.runningBtn.layer.borderWidth = 1
        self.runningBtn.layer.borderColor = CGColor(red: 74, green: 74, blue: 74, alpha: 1)
        
        self.completeBtn.layer.cornerRadius = 15
        self.completeBtn.layer.masksToBounds = true
        self.completeBtn.layer.borderWidth = 1
        self.completeBtn.layer.borderColor = CGColor(red: 74, green: 74, blue: 74, alpha: 1)
        
        self.userImg.layer.cornerRadius = self.userImg.frame.height / 2
        self.userImg.layer.masksToBounds = true
        self.userImg.layer.borderWidth = 1
        self.userImg.layer.borderColor = CGColor(red: 74, green: 74, blue: 74, alpha: 1)
        
        calendar.layer.cornerRadius = 20
        calendar.layer.masksToBounds = true
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.scope = .week

        self.listTable.layer.cornerRadius = 20
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        self.currentDate.text = formatter.string(from: Date())
        swipe()
    }
    
    func loadData() {
        var complete = [Int]()
        
        guard let userID = Auth.auth().currentUser?.email else { return }
        self.db.collection(userID).addSnapshotListener {(querySnapshot, err) in
            self.dbTitles.removeAll()
            self.firstDates.removeAll()
            self.lastDates.removeAll()
            self.eventDates.removeAll()
            self.runningCount = 0
            self.completeCount = 0
            self.calendar.reloadData()
            
            if err == nil {
                for document in querySnapshot!.documents {
                    if document.documentID == "UserData" {
                        let userName = document.data()["UserName"] as! String
                        self.userName.text = "Hello, \(userName)님"
                    } else if document.documentID != "UserData" {
                        self.dbID.append(document.documentID)
                        self.dbTitles.append(document.data()["Title"] as! String)
                        
                        let first = (document["Dates"] as! [String]).sorted(by: <).first!
                        let last = (document["Dates"] as! [String]).sorted(by: <).last!
                        let event = (document["Dates"] as! [String]).sorted(by: <)
                        
                        self.firstDates.append(first)
                        self.lastDates.append(last)
                        self.eventDates.append(event)
                        
                        let dates = (document["Dates"] as! [String]).sorted(by: <)
                        for number in 0...dates.count-1 {
                            let dateFields = document[dates[number]] as! [String: String]
                            let text = dateFields["Text"]!
                            if text == "" {
                                complete.append(0)
                            } else {
                                complete.append(3)
                            }
                        }
                        if complete.contains(0) {
                            self.runningCount += 1
                        } else {
                            self.completeCount += 1
                            let title = document.data()["Title"] as! String
                            if let index = self.dbTitles.firstIndex(of: title) {
                                self.dbTitles.remove(at: index)
                            }
                        }
                        complete.removeAll()
                    }
                    self.runningBtn.setTitle("\(self.runningCount)", for: .normal)
                    self.completeBtn.setTitle("\(self.completeCount)", for: .normal)
                }
            }
            self.listTable.reloadData()
        }
    }
    
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
}
//MARK: UITableView
extension homeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.dbTitles.count == 0 {
            return 1
        } else {
            return self.dbTitles.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.dbTitles.count == 0 {
            let cell = listTable.dequeueReusableCell(withIdentifier: "homeEmptyCell", for: indexPath) as! homeEmptyCell
            cell.title.text = "아무것도 없어요"
            cell.periodText.text = "아무것도 없어요"
            return cell
        } else {
            let cell = listTable.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! homeCell
            cell.title.text = self.dbTitles[indexPath.row]
            cell.periodText.text = "\(self.firstDates[indexPath.row]) ~ \(self.lastDates[indexPath.row])"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.dbTitles.count == 0 {
            return self.listTable.frame.height
        } else {
            return self.listTable.frame.height/3
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 5
     }

}
//MARK: FSCalendar
extension homeVC: FSCalendarDelegate, FSCalendarDataSource {
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
            calendar.scope = .week
        }
        else if swipe.direction == .down {
            calendar.scope = .month
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
            calendarHeight.constant = self.view.bounds.height / 3
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
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFomatter = DateFormatter()
        dateFomatter.dateFormat = "yyyy-MM-dd"
        let selectDay = dateFomatter.string(from: date)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AppSelect") as! SelectCalendarVC
        vc.documentID = self.dbID
        vc.date = selectDay
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

class homeEmptyCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var periodText: UILabel!
}

class homeCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var periodText: UILabel!
}
