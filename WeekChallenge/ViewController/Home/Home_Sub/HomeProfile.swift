//
//  HomeProfile.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/11.
//

import UIKit
import Firebase
import FirebaseStorage
import SDWebImage

class HomeProfile: UIViewController, UIGestureRecognizerDelegate {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var userImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backView.layer.cornerRadius = 20
        backView.layer.masksToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(backTap(sender:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        loadData()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @objc func backTap(sender: UITapGestureRecognizer) {
        print("tap")
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadData() {
        guard let userID = Auth.auth().currentUser?.email else { return }
        self.db.collection(userID).document("UserData").getDocument { (document, err) in
            if err == nil {
                if document!["Profile"] as! String == "" {
                    self.userImg.image = UIImage(named: "profileIcon")
                } else {
                    let img = document!["Profile"] as! String
                    Storage.storage().reference(forURL: img).downloadURL { (url, error) in
                        self.userImg.sd_setImage(with: url!, completed: nil)
                    }
                }
            }
        }
    }
}
