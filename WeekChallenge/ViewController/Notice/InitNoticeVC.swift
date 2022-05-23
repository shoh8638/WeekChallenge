//
//  InitNoticeVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/05/23.
//

import UIKit

class InitNoticeVC: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var sampleImg: UIImageView!
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var notShowBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var imgArr = ["게시물","계정 설정","닫기","로그아웃","설정","플랜추가"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        observerNoti()
        
        pageControll.currentPage = 0
        pageControll.numberOfPages = imgArr.count
        pageControll.currentPageIndicatorTintColor = .lightGray
        pageControll.backgroundColor = .clear
        
        sampleImg.image = UIImage(named: imgArr[0])
        
        notShowBtn.setTitle("이전", for: .normal)
        notShowBtn.isEnabled = false
        notShowBtn.addTarget(self, action: #selector(preButton), for: .touchUpInside)
        
        nextBtn.setTitle("다음", for: .normal)
        nextBtn.addTarget(self, action: #selector(nextButton), for: .touchUpInside)
    }
    
    func isShowable() -> Bool {
        var result = true
        let userDefaults = UserDefaults.standard
        let checkInfo = userDefaults.string(forKey: "result")
        let todayInfo = userDefaults.string(forKey: "today")
        let fomatter = DateFormatter()
        fomatter.dateFormat = "yyyy-MM-dd"
        let today = fomatter.string(from: Date())

        if checkInfo == nil {
            switch todayInfo?.compare(today) {
            case .orderedSame:
                result = false
            case .orderedAscending:
                result = false
            case .orderedDescending:
                result = true
            default:
                result = true
            }
        } else if checkInfo != nil {
            result = false
        }
        return result
    }
    
    @objc func nextButton(sender: UIButton!) {
        if nextBtn.currentTitle == "다음" {
            NotificationCenter.default.post(name: NSNotification.Name("nextBtn"), object: nil, userInfo: nil)
        } else if nextBtn.currentTitle == "닫기" {
            NotificationCenter.default.post(name: NSNotification.Name("CloseNoti"), object: nil, userInfo: nil)
        }
    }
    
    @objc func preButton(sender: UIButton!) {
        if notShowBtn.currentTitle == "이전" {
            NotificationCenter.default.post(name: NSNotification.Name("preBtn"), object: nil, userInfo: nil)
        } else if notShowBtn.currentTitle == "다시보지않기" {
            NotificationCenter.default.post(name: NSNotification.Name("notShowalbe"), object: nil, userInfo: nil)
        }
    }
    
    func observerNoti() {
        NotificationCenter.default.addObserver(self, selector: #selector(nextBtn(_:)), name: Notification.Name("nextBtn"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(closeBtn(_:)), name: Notification.Name("CloseNoti"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(preBtn(_:)), name: Notification.Name("preBtn"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notShowalbe(_:)), name: Notification.Name("notShowalbe"), object: nil)
    }
    
    @objc func nextBtn(_ notification: Notification) {
        print("nextBtn")
        let nextPage = pageControll.currentPage + 1
        
        if nextPage < imgArr.count {
            pageControll.currentPage = nextPage
            let nextImg = imgArr[nextPage]
            sampleImg.image = UIImage(named: nextImg)
            
            if imgArr[nextPage] == imgArr.last {
                self.notShowBtn.isEnabled = true
                self.notShowBtn.setTitle("다시보지않기", for: .normal)
                self.nextBtn.setTitle("닫기", for: .normal)
            } else {
                self.notShowBtn.isEnabled = true
                self.notShowBtn.setTitle("이전", for: .normal)
            }
        }
    }
    
    @objc func preBtn(_ notification: Notification) {
        print("preBtn")
        if pageControll.currentPage != 0 {
            let pretPage = pageControll.currentPage - 1
            pageControll.currentPage = pretPage
            let preImg = imgArr[pretPage]
            sampleImg.image = UIImage(named: preImg)
        }
        self.notShowBtn.isEnabled = false
    }
    
    @objc func notShowalbe(_ notification: Notification) {
        let userDefaults = UserDefaults.standard
        userDefaults.set("true", forKey: "result")
        UIView.animate(withDuration: 0.5) {
            self.backgroundView.alpha = 0.0
        } completion: { _ in
            self.dismiss(animated: true)
        }
    }
    
    @objc func closeBtn(_ notification: Notification) {
        let fomatter = DateFormatter()
        fomatter.dateFormat = "yyyy-MM-dd"
        let today = fomatter.string(from: Date())
        let userDefaults = UserDefaults.standard
        userDefaults.set(today, forKey: "today")
        UIView.animate(withDuration: 0.5) {
            self.backgroundView.alpha = 0.0
        } completion: { _ in
            self.dismiss(animated: true)
        }
    }
}
