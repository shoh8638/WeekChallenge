//
//  ChangePhotoVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/15.
//

import UIKit

class ChangePhotoVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func bakcGes(_ sender: UIGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
}
