//
//  Database.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/14.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

typealias completionHandler = (Any)->()
typealias dateHandler = ([[Int]])->()

class Database {
    let db = Firestore.firestore()
    
    func signInDB(id: String, email: String, pwd: String, username: String) {
        db.collection(id).document("UserData").setData(["Email":email,"password": pwd, "UserName": username]) { err in
            guard err == nil else {
                return print("SignInDB err: \(err!)")
            }
            print("SignInDB Success")
        }
    }
    
    func createDB(folderName: String, date: Dictionary<String, Any> ) {
        if let userID = Auth.auth().currentUser?.email {
            let randomNum = arc4random_uniform(999999)
            db.collection(userID).document("\(folderName)+\(randomNum)").setData(["Title": folderName]) { err in
                guard err == nil else {
                    return print("createDB err: \(err!)")
                }
                let path = self.db.collection(userID).document("\(folderName)+\(randomNum)")
                for i in date {
                    let key = i.key
                    path.updateData([key : ["Title": "", "Image": "", "Text": ""]])
                    path.updateData(["Dates" : FieldValue.arrayUnion([key])])
                }
                print("createDB Success")
            }
        }
    }
    
    func updateDB(userID: String, userFolder: String, current: String, title: String, image: String, text: String) {
        let path = db.collection(userID).document(userFolder)
        path.updateData([current: ["Title": title, "Image": image, "Text": text]])
    }
    
    func removeDB(userID: String, userFolder: String) {
        let path = db.collection(userID).document(userFolder)
        path.updateData(["": FieldValue.arrayRemove(["",""])])
    }
    
    func modifyDB() {
        
    }
    
    func checkDB(userID: String, completionHandler: @escaping completionHandler ) {
        db.collection(userID).addSnapshotListener {(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                completionHandler(querySnapshot!.count)
            }
        }
    }
}

