//
//  CreateVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/11.
//

import UIKit
import Firebase
import SwiftOverlays
import LSHContributionView

class CreateVC: UIViewController, UIGestureRecognizerDelegate {
    
    var dateString: String = ""
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var LSHView: UIView!
    
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var periodPicker: UIDatePicker!
    
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectService().Network(view: self)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(backTap(sender:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        
        setUp()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @objc func backTap(sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUp() {
        ApplyService().onlyCornerApply(view: backView)
        ApplyService().onlyCornerApply(view: firstView)
        ApplyService().onlyCornerApply(view: firstView)
        
        periodPicker.addTarget(self, action: #selector(datePicker), for: .valueChanged)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateString = formatter.string(from: periodPicker.date)
        
        exampleView()
    }
    //date 선택한 날 기준으로 5일 하기
    @objc func datePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateString = formatter.string(from: periodPicker.date)
    }
    
    @IBAction func okBtn(_ sender: Any) {
        let text = self.titleText.text
        
        self.showTextOverlay("잠시만 기다려주세요!")
        if text!.contains("+") {
            let alert = UIAlertController(title: "알림", message: "+를 빼주세요!", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            self.removeAllOverlays()
        } else if text == "" {
            let alert = UIAlertController(title: "알림", message: "제목을 입력해주세요", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            self.removeAllOverlays()
        } else {
            firebaseService().createDB(folderName: self.titleText.text!, date: PlanDate().fiveDate(current: dateString))
            self.removeAllOverlays()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CreateVC {
    func exampleView() {
        let dataSquare = [ [0,0,0,0,0]]
        let contributeView = LSHContributionView(frame: CGRect(x: 0, y: 0, width: LSHView.bounds.width, height: LSHView.bounds.height))
        contributeView.data = dataSquare
        contributeView.colorScheme = "Halloween"
        contributeView.layer.cornerRadius = 15
        contributeView.layer.masksToBounds = true
        contributeView.backgroundColor = UIColor(red: 74, green: 74, blue: 74, alpha: 1)
        LSHView.addSubview(contributeView)
    }
}
