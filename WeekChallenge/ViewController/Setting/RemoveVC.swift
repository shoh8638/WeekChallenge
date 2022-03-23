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
    
    let db = Firestore.firestore()
    let storageRef = Storage.storage().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectService().Network(view: self)
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
            if username != "" {
                self.message.text = "\(username)님 로그아웃 하시겠습니까?"
            } else {
                self.message.text = ""
            }
            
        }
    }
    
    @IBAction func bakcGes(_ sender: UIGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancleBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okBtn(_ sender: Any) {
        guard let userID = Auth.auth().currentUser?.email else { return }
        
        let storagePath = "gs://week-challenge-67756.appspot.com/\(userID)/\(userID)"
        var spaceRef = storageRef.child(userID)
        spaceRef = Storage.storage().reference(forURL: storagePath)
        
        spaceRef.delete()
        
        self.db.collection(userID).getDocuments { (document, err) in
            if let err = err {
                print("remove err: \(err)")
            } else {
                for document in document!.documents {
                    if document.documentID != "UserData" {
                        self.db.collection(userID).document(document.documentID).delete { err in
                            if let err = err {
                                print("userData err: \(err)")
                            } else {
                                print("Success")
                            }
                        }
                    } else {
                        let path =  self.db.collection(userID).document(document.documentID)
                        path.updateData(["Email": ""])
                        path.updateData(["Profile": ""])
                        path.updateData(["UserName": ""])
                        path.updateData(["password": ""])
                    }
                }
            }
        }
        
        Auth.auth().currentUser?.delete(completion: { err in
            if let err = err {
                print("removeAccount err: \(err)")
            } else {
                self.view.window?.rootViewController?.dismiss(animated: false, completion: {
                    let loginView = LoginVC()
                    loginView.modalPresentationStyle = .fullScreen
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController?.present(loginView, animated: true)
                    print("removeAccount")
                })
            }
        })
    }
}
