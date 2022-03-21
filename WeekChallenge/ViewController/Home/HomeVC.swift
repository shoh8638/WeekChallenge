//
//  HomeVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/10.
//

import UIKit
import Firebase
import FSCalendar
import FirebaseStorage

//진행중 / 완료 -> cell height 수정
class HomeVC: UIViewController, UIGestureRecognizerDelegate {
    
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
    @IBOutlet weak var runningBtn: UIButton!
    @IBOutlet weak var completeBtn: UIButton!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarHeight: NSLayoutConstraint!
    @IBOutlet weak var listTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Connectivity().Network(view: self)
        listTable.rowHeight = UITableView.automaticDimension
        setupView()
        loadData()
        initRefresh()
    }

    override func viewWillDisappear(_ animated: Bool) {
        setImg()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }

    func setupView() {
        self.userView.layer.cornerRadius = 20
        applyShadow(view: self.userView, color: UIColor.black.cgColor, alpha: 0.14, x: 10, y: 0, blur: 7)
        
        self.addBtn.layer.cornerRadius = 15
        self.addBtn.layer.borderWidth = 1
        self.addBtn.layer.borderColor = CGColor(red: 74, green: 74, blue: 74, alpha: 1)
        buttonApplyShadow(btn: addBtn, color: UIColor.black.cgColor, alpha: 0.14, x: 8, y: 0, blur: 7)
        self.runningBtn.layer.cornerRadius = 15
        self.runningBtn.layer.borderWidth = 1
        self.runningBtn.layer.borderColor = CGColor(red: 74, green: 74, blue: 74, alpha: 1)
        buttonApplyShadow(btn: runningBtn, color: UIColor.black.cgColor, alpha: 0.14, x: 8, y: 0, blur: 7)
        
        self.completeBtn.layer.cornerRadius = 15
        self.completeBtn.layer.borderWidth = 1
        self.completeBtn.layer.borderColor = CGColor(red: 74, green: 74, blue: 74, alpha: 1)
        buttonApplyShadow(btn: completeBtn, color: UIColor.black.cgColor, alpha: 0.14, x: 8, y: 0, blur: 7)
        
        self.userImg.layer.cornerRadius = self.userImg.frame.height / 2
        self.userImg.layer.masksToBounds = true
        self.userImg.layer.borderWidth = 1
        self.userImg.layer.borderColor = CGColor(red: 74, green: 74, blue: 74, alpha: 1)
        
        calendar.layer.cornerRadius = 20
        applyShadow(view: self.calendar, color: UIColor.black.cgColor, alpha: 0.14, x: 10, y: 0, blur: 7)
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.scope = .week
        
        self.listTable.layer.cornerRadius = 20
        talbeApplyShadow(table: listTable, color: UIColor.black.cgColor, alpha: 0.14, x: 10, y: 0, blur: 7)
    
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        self.currentDate.text = formatter.string(from: Date())
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imgTap(sender:)))
        self.userImg.addGestureRecognizer(tap)
        self.userImg.isUserInteractionEnabled = true
        
        setImg()
        swipe()
    }
    
    func applyShadow(view: UIView,color: CGColor, alpha: Float, x: Int, y: Int, blur: CGFloat) {
        view.layer.masksToBounds = false
        view.layer.shadowColor = color
        view.layer.shadowOpacity = alpha
        view.layer.shadowOffset = CGSize(width: x, height: y)
        view.layer.shadowRadius = blur / 2.0
    }
    
    func talbeApplyShadow(table: UITableView,color: CGColor, alpha: Float, x: Int, y: Int, blur: CGFloat) {
        table.layer.masksToBounds = false
        table.layer.shadowColor = color
        table.layer.shadowOpacity = alpha
        table.layer.shadowOffset = CGSize(width: x, height: y)
        table.layer.shadowRadius = blur / 2.0
    }
    
    func buttonApplyShadow(btn: UIButton,color: CGColor, alpha: Float, x: Int, y: Int, blur: CGFloat) {
        btn.layer.masksToBounds = false
        btn.layer.shadowColor = color
        btn.layer.shadowOpacity = alpha
        btn.layer.shadowOffset = CGSize(width: x, height: y)
        btn.layer.shadowRadius = blur / 2.0
    }
    
    func setImg() {
        guard let userID = Auth.auth().currentUser?.email else { return }
        self.db.collection(userID).document("UserData").addSnapshotListener { (document, err) in
            if err == nil {
                if document!["Profile"] as! String != "" {
                    let img = document!["Profile"] as! String
                    Storage.storage().reference(forURL: img).downloadURL { (url, error) in
                        if url != nil {
                            self.userImg.sd_setImage(with: url!, completed: nil)
                        } else {
                            print("HomeVC url err: \(error!)")
                        }
                        
                    }
                } else {
                    self.userImg.image = UIImage(named: "profileIcon")
                }
            }
        }
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
                        if userName != "" {
                            self.userName.text = "Hello, \(userName)님"
                        } else {
                            self.userName.text = ""
                        }
                        
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
    
    
    @objc func imgTap(sender: UIGestureRecognizer) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeProfile") as! HomeProfile
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func addBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeCreate") as! CreateVC
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func runningBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeRun") as! RunningVC
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func completeBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeCom") as! CompleteVC
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
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
            let cell = listTable.dequeueReusableCell(withIdentifier: "homeEmptyCell", for: indexPath) as! homeEmptyCell
            cell.title.text = "아무것도 없어요"
            cell.periodText.text = ""
            return cell
        } else {
            let cell = listTable.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! homeCell
            cell.layer.cornerRadius = 20
            cell.layer.masksToBounds = true
            cell.title.text = self.dbTitles[indexPath.row]
            cell.periodText.text = "\(self.firstDates[indexPath.row]) ~ \(self.lastDates[indexPath.row])"
            return cell
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if self.dbTitles.count == 0 {
//            return self.listTable.frame.height/2
//        } else {
//            return self.listTable.frame.height/3
//        }
//    }
}
//MARK: FSCalendar
extension HomeVC: FSCalendarDelegate, FSCalendarDataSource {
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
            print(self.listTable.frame.height)
        }
        else if swipe.direction == .down {
            calendar.scope = .month
            print(self.listTable.frame.height)
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
