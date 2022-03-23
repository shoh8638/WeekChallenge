//
//  DataService.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/23.
//

import UIKit
import Firebase
import FSCalendar
import SDWebImage
//loadData 관련 정의
class DataService {
    var homeM = HomeModel()
    var runM = ListBtnModel()
    let db = Firestore.firestore()
    let userID = Auth.auth().currentUser!.email!
    
    func hLoadData(table: UITableView, calendar:FSCalendar, userLabel: UILabel, runningBtn: UIButton, completeBtn: UIButton, completion: @escaping (HomeModel) -> ()) {
        var complete = [Int]()
       
        self.db.collection(self.userID).addSnapshotListener {(querySnapshot, err) in
            self.homeM.dbID.removeAll()
            self.homeM.dbTitles.removeAll()
            self.homeM.firstDates.removeAll()
            self.homeM.lastDates.removeAll()
            self.homeM.eventDates.removeAll()
            self.homeM.runningCount = 0
            self.homeM.completeCount = 0
            calendar.reloadData()
            
            if err == nil {
                for document in querySnapshot!.documents {
                    if document.documentID == "UserData" {
                        let userName = document.data()["UserName"] as! String
                        if userName != "" {
                            userLabel.text = "Hello, \(userName)님"
                        } else {
                            userLabel.text = ""
                        }
                        
                    } else if document.documentID != "UserData" {
                        self.homeM.dbID.append(document.documentID)
                        self.homeM.dbTitles.append(document.data()["Title"] as! String)
                        
                        self.homeM.firstDates.append((document["Dates"] as! [String]).sorted(by: <).first!)
                        self.homeM.lastDates.append((document["Dates"] as! [String]).sorted(by: <).last!)
                        self.homeM.eventDates.append((document["Dates"] as! [String]).sorted(by: <))
                        
                        let dates = (document["Dates"] as! [String]).sorted(by: <)
                        for number in 0...dates.count-1 {
                            let dateFields = document[dates[number]] as! [String: String]
                            let text = dateFields["Text"]!
                            if text == "" {
                                complete.append(0)
                            } else {
                                complete.append(3)
                            }
                        }
                        if complete.contains(0) {
                            self.homeM.runningCount += 1
                        } else {
                            self.homeM.completeCount += 1
                            let title = document.data()["Title"] as! String
                            if let index = self.homeM.dbTitles.firstIndex(of: title) {
                                self.homeM.dbTitles.remove(at: index)
                            }
                        }
                        complete.removeAll()
                    }
                    runningBtn.setTitle("\(self.homeM.runningCount)", for: .normal)
                    completeBtn.setTitle("\(self.homeM.completeCount)", for: .normal)
                }
            }
            completion(self.homeM)
            table.reloadData()
        }
    }
    
    func setImg(userImg: UIImageView) {
        guard let userID = Auth.auth().currentUser?.email else { return }
        self.db.collection(userID).document("UserData").addSnapshotListener { (document, err) in
            if err == nil {
                if document!["Profile"] as! String != "" {
                    let img = document!["Profile"] as! String
                    Storage.storage().reference(forURL: img).downloadURL { (url, error) in
                        if url != nil {
                            userImg.sd_setImage(with: url!, completed: nil)
                        } else {
                            print("HomeVC url err: \(error!)")
                        }
                    }
                }
            }
        }
    }
    
    func rLoadData(table: UITableView, completion: @escaping (ListBtnModel) -> ()) {
        var complete = [Int]()
        
        self.db.collection(self.userID).addSnapshotListener {(querySnapshot, err) in
            
            if err == nil {
                for document in querySnapshot!.documents {
                    if document.documentID != "UserData" {
                        let dates = (document["Dates"] as! [String]).sorted(by: <)
                        
                        for number in 0...dates.count-1 {
                            let dateFields = document[dates[number]] as! [String: String]
                            let text = dateFields["Text"]!
                            if text == "" {
                                complete.append(0)
                            } else {
                                complete.append(3)
                            }
                        }
                        if complete.contains(0) {
                            self.runM.titles.append(document["Title"] as! String)
                            self.runM.firstPeriod.append(dates.first!)
                            self.runM.lastPeriod.append(dates.last!)
                        }
                        complete.removeAll()
                    }
                }
            }
            completion(self.runM)
            table.reloadData()
        }
    }
    
    func cLoadData(table: UITableView, completion: @escaping (ListBtnModel) -> ()) {
        var complete = [Int]()
        
        self.db.collection(self.userID).addSnapshotListener {(querySnapshot, err) in
            
            if err == nil {
                for document in querySnapshot!.documents {
                    if document.documentID != "UserData" {
                        let dates = (document["Dates"] as! [String]).sorted(by: <)
                        
                        for number in 0...dates.count-1 {
                            let dateFields = document[dates[number]] as! [String: String]
                            let text = dateFields["Text"]!
                            if text == "" {
                                complete.append(0)
                            } else {
                                complete.append(3)
                            }
                        }
                        if !complete.contains(0) {
                            self.runM.titles.append(document["Title"] as! String)
                            self.runM.firstPeriod.append(dates.first!)
                            self.runM.lastPeriod.append(dates.last!)
                        }
                        complete.removeAll()
                    }
                }
            }
            completion(self.runM)
            table.reloadData()
        }
    }
    
    func sLoadData(table: UITableView, date: String, completion: @escaping (ListBtnModel) -> ()) {
        var complete = [Int]()
        
        self.db.collection(self.userID).addSnapshotListener {(querySnapshot, err) in
            
            if err == nil {
                for document in querySnapshot!.documents {
                    if document.documentID != "UserData" {
                        let dates = (document["Dates"] as! [String]).sorted(by: <)
                        
                        for number in 0...dates.count-1 {
                            let dateFields = document[dates[number]] as! [String: String]
                            let text = dateFields["Text"]!
                            if text == "" {
                                complete.append(0)
                            } else {
                                complete.append(3)
                            }
                        }
                        
                        if dates.contains(date) {
                            self.runM.titles.append(document["Title"] as! String)
                            self.runM.firstPeriod.append(dates.first!)
                            self.runM.lastPeriod.append(dates.last!)
                        }
                        
                        if !complete.contains(0) {
                            if let index = self.runM.titles.firstIndex(of: document["Title"] as! String){
                                self.runM.titles.remove(at: index)
                            }
                            
                            if let index = self.runM.firstPeriod.firstIndex(of: dates.first!) {
                                self.runM.firstPeriod.remove(at: index)
                            }
                            
                            if let index = self.runM.lastPeriod.firstIndex(of: dates.last!) {
                                
                                self.runM.lastPeriod.remove(at: index)
                            }
                        }
                        complete.removeAll()
                    }
                }
            }
            completion(self.runM)
            table.reloadData()
        }
    }
}
