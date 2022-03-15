//
//  RemoveVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/15.
//

import UIKit
import Firebase
import SwiftOverlays

class RemoveVC: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var okBtn: UIButton!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Connectivity().Network(view: self)
        setUp()
    }
    
    
    func setUp() {       
        self.mainView.layer.cornerRadius = 20
        self.mainView.layer.masksToBounds = true
        
        guard let userID = Auth.auth().currentUser?.email  else { return }
        let docRef = self.db.collection(userID).document("UserData")
        docRef.getDocument { document, err in
            let data = document!.data()
            let username = data!["UserName"] as! String
            self.message.text = "\(username)님 로그아웃 하시겠습니까?"
        }
    }
    
    @IBAction func bakcGes(_ sender: UIGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancleBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "removeAccount" {
            Auth.auth().currentUser?.delete(completion: { err in
                if let err = err {
                    print("removeAccount err: \(err)")
                } else {
                    guard let userID = Auth.auth().currentUser?.email else { return }
                    self.db.collection(userID).document().delete()
                    Storage.storage(url: "gs://week-challenge-67756.appspot.com/\(userID)").reference().delete()
                    print("removeAll")
                }
            })
        }
    }
}
