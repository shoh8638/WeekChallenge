//
//  Database.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/14.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import Firebase

typealias completionHandler = (Any)->()

class Database {
    let db = Firestore.firestore()
    var folder: Array<String> = [""]
    

    func signInDB(id: String, email: String, pwd: String, nickname: String) {
        db.collection(id).document("UserData").setData(["Email":email,"password": pwd, "Nickname": nickname]) { err in
            guard err == nil else {
                return print("SignInDB err: \(err!)")
            }
            print("SignInDB Success")
        }
    }
    
    func createDB(folderName: String, title: String, date: Array<String> ) {
        db.collection("aaa@aaa.com").document(folderName).setData(["Title": title, "Date": date]) { err in
            guard err == nil else {
                return print("createDB err: \(err!)")
            }
            print("createDB Success")
            
            self.folder.append(folderName)
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
