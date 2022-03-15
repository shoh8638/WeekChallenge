//
//  aaaViewController.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/15.
//

import UIKit

class aaaViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet var back: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UIGestureRecognizer(target: self, action: #selector(backTap(sender:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @objc func backTap(sender: UITapGestureRecognizer) {
        print("tap")
        self.dismiss(animated: true, completion: nil)
    }
}
