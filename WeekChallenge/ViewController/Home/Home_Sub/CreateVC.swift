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
        setUp()
    }
    
    func setUp() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(backTap(sender:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        
        ApplyService().onlyCornerApply(view: backView)
        ApplyService().onlyCornerApply(view: firstView)
        ApplyService().onlyCornerApply(view: firstView)
        
        periodPicker.addTarget(self, action: #selector(datePicker), for: .valueChanged)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateString = formatter.string(from: periodPicker.date)
        
        contributeView().exampleView(view: LSHView)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @objc func backTap(sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func datePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateString = formatter.string(from: periodPicker.date)
    }
    
    @IBAction func okBtn(_ sender: Any) {
        let text = self.titleText.text
        
        self.showTextOverlay("잠시만 기다려주세요!")
        if text!.contains("+") {
            AlertService().basicAlert(viewController: self, message: "+를 빼주세요!")
            self.removeAllOverlays()
        } else if text == "" {
            AlertService().basicAlert(viewController: self, message: "제목을 입력해주세요")
            self.removeAllOverlays()
        } else {
            FirebaseService().createDB(folderName: self.titleText.text!, date: PlanDate().fiveDate(current: dateString))
            self.removeAllOverlays()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
