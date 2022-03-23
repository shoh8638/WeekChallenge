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
    
    var homeM = HomeModel()
    var homeVM = HomeViewwModel()
    let applyLayout = ApplyService()

    
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
        ConnectService().Network(view: self)
        listTable.rowHeight = UITableView.automaticDimension
        setupView()
        loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setImg()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func setupView() {
        applyLayout.viewApplyLayer(view: userView)
        applyLayout.buttonApplyLayer(btn: addBtn)
        applyLayout.buttonApplyLayer(btn: runningBtn)
        applyLayout.buttonApplyLayer(btn: completeBtn)
        applyLayout.imgApplyLayer(img: userImg)
        applyLayout.viewApplyLayer(view: calendar)
        applyLayout.tableApplyLayer(table: listTable)
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.scope = .week
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        self.currentDate.text = formatter.string(from: Date())
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imgTap(sender:)))
        self.userImg.addGestureRecognizer(tap)
        self.userImg.isUserInteractionEnabled = true
        
        setImg()
        swipe()
    }
    
    func setImg() {
        DataService().setImg(userImg: userImg)
    }
    
    func loadData() {
        DataService().hLoadData(table: listTable, calendar: calendar, userLabel: userName, runningBtn: runningBtn, completeBtn: completeBtn) { model in
            self.homeM = model
        }
    }
    
    @objc func imgTap(sender: UIGestureRecognizer) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeProfile") else { return }
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func addBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeCreate")
        vc!.modalTransitionStyle = .crossDissolve
        vc!.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func runningBtn(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeRun") else { return }
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func completeBtn(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeCom") else { return }
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
//MARK: UITableView
extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeVM.numberOfItem(homeM: self.homeM)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTable.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! homeCell
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        cell.title.text = homeVM.numberOfTitle(homeM: self.homeM, index: indexPath.row)
        cell.periodText.text = homeVM.numberOfPeriod(homeM: self.homeM, index: indexPath.row)
        return cell
    }
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
        if self.homeM.firstDates.contains(day) {
            return 1
        } else if self.homeM.lastDates.contains(day) {
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
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeSelect") as! SelectCalendarVC
        vc.date = selectDay
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

class homeCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var periodText: UILabel!
}
