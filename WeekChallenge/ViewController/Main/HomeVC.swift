//
//  HomeVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/10.
//

import UIKit
import Firebase
import LSHContributionView
import FSCalendar

class HomeVC: UIViewController {
    
    @IBOutlet weak var wecolmeText: UILabel!
    @IBOutlet weak var calendarHeight: NSLayoutConstraint!
    @IBOutlet weak var fsCalender: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Connectivity().Network(view: self)
        checkUser()
        calendarSetip()
        swipe()
    }

    override func viewWillAppear(_ animated: Bool) {
        checkUser()
        calendarSetip()
        swipe()
    }
    func checkUser() {
        if let userID = Auth.auth().currentUser?.email {
            Database().checkDB(userID: userID) { count in
                let num = count as! Int
                if num > 1 {
                    self.wecolmeText.text = "현재 \(num-1)개 플랜이 실행중입니다!"
                } else {
                    self.wecolmeText.text = "버튼을 눌러 플랜을 생성해주세요!"
                }
            }
        }
    }
    
    func calendarSetip() {
        self.fsCalender.dataSource = self
        self.fsCalender.delegate = self
        fsCalender.scope = .week
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

    @IBAction func settingButton(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppSetting") as! SettingVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

extension HomeVC: FSCalendarDelegate, FSCalendarDataSource {
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
}
