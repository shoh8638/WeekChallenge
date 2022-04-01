//
//  HomeVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/10.
//

import UIKit
import FSCalendar

class HomeVC: UIViewController, UIGestureRecognizerDelegate {
    
    let applyLayout = LayoutService()
    var userVM : UserViewModel!
    var countVM: CountViewModel!
    var dataVM: DataViewModel!
    
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
        setupView()
        userLoadData()
        swipe()
        countLoadData()
        loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        userLoadData()
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
        
        listTable.rowHeight = UITableView.automaticDimension
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        self.currentDate.text = formatter.string(from: Date())
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imgTap(sender:)))
        self.userImg.addGestureRecognizer(tap)
        self.userImg.isUserInteractionEnabled = true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func userLoadData() {
        DataService().userLodaData { model in
            self.userVM = UserViewModel(UserM: model)
            self.userName.text = "Hello! \(self.userVM.loadUserName())"
            self.userVM.loadUserImg(img: self.userImg)
        }
    }
    
    func countLoadData() {
        DataService().countLoadData { model in
            self.countVM = CountViewModel(countM: model)
            self.runningBtn.setTitle(String(self.countVM.runningCount()), for: .normal)
            self.completeBtn.setTitle(String(self.countVM.completeCount()), for: .normal)
        }
    }
    
    func loadData() {
        DataService().HomeLoadData(table: listTable) { model in
            self.dataVM = DataViewModel(dataM: model)
        }
    }
    
    @objc func imgTap(sender: UIGestureRecognizer) {
        ConnectService().sendVC(main: self, name: "HomeProfile")
    }
    
    @IBAction func addBtn(_ sender: Any) {
        ConnectService().sendVC(main: self, name: "HomeCreate")
    }
    
    @IBAction func runningBtn(_ sender: Any) {
        ConnectService().sendVC(main: self, name: "HomeRun")
    }
    
    @IBAction func completeBtn(_ sender: Any) {
        ConnectService().sendVC(main: self, name: "HomeCom")
    }
}
//MARK: UITableView
extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataVM != nil {
            if  dataVM.numberOfRowsInSection() == 0 {
                return 1
            } else {
                return dataVM.numberOfRowsInSection()
            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if dataVM.numberOfRowsInSection() == 0 {
            let cell = listTable.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeCell
            cell.emptyUpdate(info: "진행중인 플랜이 없습니다.")
            return cell
        } else {
            let cell = listTable.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeCell
            let data = dataVM.numberOfCellIndex(index: indexPath.row)
            cell.dataUpdate(info: data)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return listTable.bounds.height / 2
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
        if dataVM != nil {
            if self.dataVM.numberOfEvent(index: self.dataVM.numberOfRowsInSection()).contains(day) {
                return 1
            } else {
                return 0
            }
        }
        return 0
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
