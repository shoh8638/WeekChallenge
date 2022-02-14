//
//  Database.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/14.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class Database {
    let db = Firestore.firestore()
    var userID = AuthService().userID
    var folder: Array<String> = [""]
    
    func signInDB(id: String, email: String, pwd: String, nickname: String) {
        db.collection(id).document("UserData").setData(["Email":email,"password": pwd, "Nickname": nickname]) { err in
            guard err == nil else {
                return print("SignInDB err: \(err!)")
            }
            print("SignInDB Success")
        }
    }
    
    func createDB(folderName: String, week: Array<Int>, title: Array<String>, date: Array<Int> ) {
        db.collection("aaa@aaa.com").document(folderName).setData(["DateArray": week, "Title": title, "Date": date]) { err in
            guard err == nil else {
                return print("createDB err: \(err!)")
            }
            print("createDB Success")
            
            self.folder.append(folderName)
        }
    }
    
    func updateDB(userFolder: String) {
        let path = db.collection(self.userID).document(userFolder)
        //array
        path.updateData(["": FieldValue.arrayUnion(["",""])])
        //dict
        path.updateData(["": ["": ""]])
    }
    
    func removeDB(userFolder: String) {
        let path = db.collection(self.userID).document(userFolder)
        path.updateData(["": FieldValue.arrayRemove(["",""])])
    }
    
    func modifyDB() {
        
    }
    
    func checkDB(userID: String, v: UIView) {
        db.collection("aaa@aaa.com").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if querySnapshot?.count == 1 {
                    CustomView().addView(v: v)
                }
            }
        }
    }
}
