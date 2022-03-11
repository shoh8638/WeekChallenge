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

    @IBOutlet weak var backView: UIView!
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var LSHView: UIView!
    
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var periodText: UILabel!
    
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        Connectivity().Network(view: self)
        let tap = UITapGestureRecognizer(target: self, action: #selector(backTap(sender:)))
        tap.delegate = self
        mainView.addGestureRecognizer(tap)
        setUp()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }

    func setUp() {

        self.backView.layer.cornerRadius = 20
        self.backView.layer.masksToBounds = true
        self.backView.backgroundColor = UIColor(named: "white")
        
        self.firstView.layer.cornerRadius = 15
        self.firstView.layer.masksToBounds = true
        
        self.LSHView.layer.cornerRadius = 15
        self.LSHView.layer.masksToBounds = true
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let today = formatter.string(from: Date())
        let lastDay = formatter.string(from: Calendar.current.date(byAdding: .day, value: 4, to: formatter.date(from: today)!)!)
        self.periodText.text = "\(today) ~ \(lastDay)"
        exampleView()
    }
    
    @objc func backTap(sender: UITapGestureRecognizer) {
        print("tap")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okBtn(_ sender: Any) {
        self.showTextOverlay("잠시만 기다려주세요!")
        if self.titleText.text != "" {
            Database().createDB(folderName: self.titleText.text!, date: PlanDate().fiveDate())
            self.removeAllOverlays()
            self.dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "알림", message: "제목을 입력해주세요", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            self.removeAllOverlays()
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
