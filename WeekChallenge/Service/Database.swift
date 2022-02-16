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

class Database {
    let db = Firestore.firestore()
    
    func signInDB(id: String, email: String, pwd: String, nickname: String) {
        db.collection(id).document("UserData").setData(["Email":email,"password": pwd, "Nickname": nickname]) { err in
            guard err == nil else {
                return print("SignInDB err: \(err!)")
            }
            print("SignInDB Success")
        }
    }
    
    func createDB(folderName: String, date: Dictionary<String, Any> ) {
        if let userID = Auth.auth().currentUser?.email {
            db.collection(userID).document(folderName).setData(["Title": folderName,"Date": date]) { err in
                guard err == nil else {
                    return print("createDB err: \(err!)")
                }
                print("createDB Success")
            }
        }
    }
    
    func updateDB(userID: String, userFolder: String) {
        let path = db.collection(userID).document(userFolder)
        //array
        path.updateData(["": FieldValue.arrayUnion(["",""])])
        //dict
        path.updateData(["": ["": ""]])
    }
    
    func removeDB(userID: String, userFolder: String) {
        let path = db.collection(userID).document(userFolder)
        path.updateData(["": FieldValue.arrayRemove(["",""])])
    }
    
    func modifyDB() {
        
    }
    
    func checkDB(userID: String, completionHandler: @escaping completionHandler ) {
        db.collection(userID).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                completionHandler(querySnapshot!.count)
            }
        }
    }
}
