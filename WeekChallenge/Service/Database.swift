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
    
    func signInDB(id: String, email: String, pwd: String, username: String, img: String) {
        db.collection(id).document("UserData").setData(["Email":email,"password": pwd, "UserName": username, "Profile": img]) { err in
            guard err == nil else {
                return print("SignInDB err: \(err!)")
            }
            print("SignInDB Success")
        }
    }
    
    func createDB(folderName: String, date: Dictionary<String, Any> ) {        
        guard let userID = Auth.auth().currentUser?.email else { return }
        let randomNum = arc4random_uniform(999999)
        let data = ["Title": "", "Image": "", "Text": ""]
        var dateArr = [String]()
        for i in date {
            dateArr.append(i.key)
        }
        
        db.collection(userID).document("\(folderName)+\(randomNum)").setData([
            "Title": folderName,
            "\(dateArr[0])": data,
            "\(dateArr[1])": data,
            "\(dateArr[2])": data,
            "\(dateArr[3])": data,
            "\(dateArr[4])": data,
            "Dates": dateArr
        ]) { err in
            guard err == nil else {
                return print("createDB err: \(err!)")
            }
            print("createDB Success")
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

