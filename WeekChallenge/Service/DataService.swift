//
//  DataService.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/23.
//

import UIKit
import Firebase
import SDWebImage

class DataService {
    var planM = PlanModel()
    var pDeatilM = PlanDetailModel()
    var dbM = DashBoardModel()
    var mlM = ManageListModel()
    let db = Firestore.firestore()
}

//MARK: MVVM Pattern 적용
extension DataService {
    //MARK: HomeVC
    func userLodaData(completion: @escaping (UserModel) -> ()) {
        guard let userID = Auth.auth().currentUser?.email else {return}

        self.db.collection(userID).document("UserData").addSnapshotListener {(querySnapshot, err) in
            guard let document = querySnapshot else { return }
                  guard let data = document.data() else { return }
            let userName = data["UserName"] as! String
            let imgUrl = data["Profile"] as! String
            completion(UserModel(userName: userName, imgUrl: imgUrl))
        }
    }
    
    func countLoadData(completion: @escaping (CountModel) -> ()) {
        var complete = [Int]()

        guard let userID = Auth.auth().currentUser?.email else {return}

        self.db.collection(userID).addSnapshotListener {(querySnapshot, err) in
            complete.removeAll()
            var runningCount = 0
            var completeCount = 0
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
                        runningCount += 1
                    } else {
                        completeCount += 1
                    }
                    complete.removeAll()
                }
            }
            completion( CountModel(running: runningCount, complete: completeCount))
        }
    }
    
    func HomeLoadData(table: UITableView ,completion: @escaping ([DataModel?]) -> ()) {
        var complete = [Int]()
        
        guard let userID = Auth.auth().currentUser?.email else {return}
        
        var userDLM: DataModel?
        var userArr = [userDLM]

        self.db.collection(userID).addSnapshotListener {(querySnapshot, err) in
            userArr.removeAll()
            for document in querySnapshot!.documents {
                if document.documentID != "UserData" {
                    let title = document.data()["Title"] as! String
                    let dates = (document["Dates"] as! [String]).sorted(by: <)
                    let dbID = document.documentID
                    let firstDate  = dates.first!
                    let lastDate = dates.last
                    
                    for i in 0..<dates.count {
                        let dateField = document[dates[i]] as! [String: String]
                        let text = dateField["Text"]!
                        if text == "" {
                            complete.append(0)
                        } else {
                            complete.append(3)
                        }
                    }
                    
                    if complete != [3,3,3,3,3] {
                        userDLM = DataModel(title: title, dates: dates, dbID: dbID, firstDate: firstDate, lastDate: lastDate!)
                        userArr.append(userDLM!)
                    }
                    complete.removeAll()
                }
            }
            completion(userArr)
            table.reloadData()
        }
    }
    
    func runLoadData(table: UITableView, completion: @escaping ([RSCModel?]) -> ()) {
        var complete = [Int]()
        
        guard let userID = Auth.auth().currentUser?.email else {return}
        
        var runM: RSCModel?
        var runVM = [runM]
        
        self.db.collection(userID).addSnapshotListener {(querySnapshot, err) in
            runVM.removeAll()
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
                            let title = document["Title"] as! String
                            let firstDate = dates.first!
                            let lastDate = dates.last!
                            runM = RSCModel(title: title, firstDate: firstDate, lastDate: lastDate)
                            runVM.append(runM!)
                        }
                        complete.removeAll()
                    }
                }
            }
            completion(runVM)
            table.reloadData()
        }
    }
    
    func completeLoadData(table: UITableView, completion: @escaping ([RSCModel?]) -> ()) {
        var complete = [Int]()
        
        guard let userID = Auth.auth().currentUser?.email else {return}
        
        var completeM: RSCModel?
        var completeVM = [completeM]
        
        self.db.collection(userID).addSnapshotListener {(querySnapshot, err) in
            completeVM.removeAll()
            
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
                        let title = document["Title"] as! String
                           let firstDate = dates.first!
                            let lastDate = dates.last!
                            completeM = RSCModel(title: title, firstDate: firstDate, lastDate: lastDate)
                            completeVM.append(completeM)
                        }
                        complete.removeAll()
                    }
                }
            }
            completion(completeVM)
            table.reloadData()
        }
    }
    
    
    func selecetLoadData(table: UITableView, date: String, completion: @escaping ([RSCModel?]) -> ()) {
        var complete = [Int]()
        
        guard let userID = Auth.auth().currentUser?.email else {return}
        var selectM: RSCModel?
        var selectVM = [selectM]
        
        self.db.collection(userID).addSnapshotListener {(querySnapshot, err) in
            selectVM.removeAll()
            
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
                            if complete.contains(0) {
                                let title = document["Title"] as! String
                                let firstDate = dates.first!
                                let lastDate = dates.last!
                                selectM = RSCModel(title: title, firstDate: firstDate, lastDate: lastDate)
                                selectVM.append(selectM)
                            }
                        }
                        complete.removeAll()
                    }
                }
            }
            completion(selectVM)
            table.reloadData()
        }
    }
    //MARK: PlanVC
}
//MARK: LoadData
extension DataService {
    
  
    
    func settingLoadData(userName: UILabel, userImg: UIImageView) {
        guard let userID = Auth.auth().currentUser?.email else {return}
        
        self.db.collection(userID).document("UserData").addSnapshotListener { document, err in
            if err == nil {
                let data = document!.data()
                let username = data!["UserName"] as! String
                if username != "" {
                    userName.text = username
                } else {
                    userName.text = ""
                }
                
                if document!["Profile"] as! String != "" {
                    let img = document!["Profile"] as! String
                    Storage.storage().reference(forURL: img).downloadURL { (url, error) in
                        if url != nil {
                            userImg.sd_setImage(with: url!, completed: nil)
                        } else {
                            print("SettingLoadData url err: \(error!)")
                        }
                    }
                } else {
                    userImg.image = UIImage(named: "profileIcon")
                    print("ETCVC err")
                }
            }
        }
    }
    
    func pLoadData(collection: UICollectionView, completion: @escaping (PlanModel) -> ()) {
        var complete = [Int]()
        guard let userID = Auth.auth().currentUser?.email else {return}
        
        self.db.collection(userID).addSnapshotListener {(querySnapshot, err) in
            self.planM.dbID.removeAll()
            self.planM.dbTitles.removeAll()
            self.planM.dbDate.removeAll()
            self.planM.firstDates.removeAll()
            self.planM.lastDates.removeAll()
            if err == nil {
                for document in querySnapshot!.documents {
                    if document.documentID != "UserData" {
                        self.planM.dbID.append(document.documentID)
                        self.planM.dbTitles.append(document.data()["Title"] as! String)
                        
                        self.planM.firstDates.append((document["Dates"] as! [String]).sorted(by: <).first!)
                        self.planM.lastDates.append((document["Dates"] as! [String]).sorted(by: <).last!)
                        
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
                        self.planM.dbDate.append(complete)
                        complete.removeAll()
                    }
                }
            }
            completion(self.planM)
            collection.reloadData()
        }
    }
    
    func pDLoadData(collection: UICollectionView, documentID: String, completion: @escaping (PlanDetailModel) -> ()) {
        guard let userID = Auth.auth().currentUser?.email else {return}
        
        self.db.collection(userID).document(documentID).addSnapshotListener { (document, err) in
            self.pDeatilM.subTitles.removeAll()
            self.pDeatilM.subImg.removeAll()
            self.pDeatilM.subText.removeAll()
            
            if err == nil {
                let dates = (document!["Dates"] as! [String]).sorted(by: <)
                for number in 0...dates.count-1 {
                    let dateFields = document![dates[number]] as! [String: String]
                    let title = dateFields["Title"]!
                    let img = dateFields["Image"]!
                    let text = dateFields["Text"]!
                    if title != "" {
                        self.pDeatilM.subTitles.append(title)
                        self.pDeatilM.subImg.append(img)
                        self.pDeatilM.subText.append(text)
                    }
                }
            }
            completion(self.pDeatilM)
            collection.reloadData()
        }
    }
    
    func boardLoadData(collection: UICollectionView, completion: @escaping (DashBoardModel) -> ()) {
        guard let userID = Auth.auth().currentUser?.email else {return}
        
        self.db.collection(userID).addSnapshotListener{ (querySnapshot, err) in
            self.dbM.dbID.removeAll()
            self.dbM.dbTitles.removeAll()
            self.dbM.userTitles.removeAll()
            self.dbM.userImg.removeAll()
            self.dbM.userText.removeAll()
            for document in querySnapshot!.documents {
                if document.documentID != "UserData" {
                    self.dbM.dbID.append(document.documentID)
                    self.dbM.dbTitles.append(document.data()["Title"] as! String)
                    
                    let dates = (document["Dates"] as! [String]).sorted(by: <)
                    for i in 0...dates.count-1 {
                        let dateFields = document[dates[i]] as! [String: String]
                        let title = dateFields["Title"]!
                        let img = dateFields["Image"]!
                        let text = dateFields["Text"]!
                        if title != "" && img != "" && text != "" {
                            self.dbM.userTitles.append(title)
                            self.dbM.userImg.append(img)
                            self.dbM.userText.append(text)
                        }
                    }
                }
            }
            completion(self.dbM)
            collection.reloadData()
        }
    }
    
    func boardSetImg(img: UIImageView, view: UIView, imgUrl: String) {
        if imgUrl != "" {
            Storage.storage().reference(forURL: imgUrl).downloadURL { (url, error) in
                if url != nil {
                    ApplyService().imgOnlyCornerApply(view: view, img: img)
                    img.sd_setImage(with: url!, completed: nil)
                } else {
                    print("DashBoardVC err: \(error!)")
                }
            }
        }
    }
    
    func searchLoadData(searchText: String, collection: UICollectionView, completion: @escaping (DashBoardModel) -> ()) {
        guard let userID = Auth.auth().currentUser?.email else {return}
        
        self.db.collection(userID).getDocuments { (querySnapshot, err) in
            for document in querySnapshot!.documents {
                if document.documentID != "UserData" {
                    let dates = (document["Dates"] as! [String]).sorted(by: <)
                    for i in 0...dates.count-1 {
                        let dateFields = document[dates[i]] as! [String: String]
                        let title = dateFields["Title"]!
                        let img = dateFields["Image"]!
                        let text = dateFields["Text"]!
                        if text.contains(searchText) {
                            self.dbM.userTitles.append(title)
                            self.dbM.userImg.append(img)
                            self.dbM.userText.append(text)
                            
                            let range = document.documentID.firstIndex(of: "+") ?? document.documentID.endIndex
                            self.dbM.dbTitles.append(String(document.documentID[..<range]))
                        }
                    }
                }
            }
            completion(self.dbM)
            collection.reloadData()
        }
    }
    
    func logoutLoadData(message: UILabel) {
        guard let userID = Auth.auth().currentUser?.email else {return}
        
        self.db.collection(userID).document("UserData").getDocument { document, err in
            let data = document!.data()
            let username = data!["UserName"] as! String
            if username != "" {
                message.text = "\(username)님 로그아웃 하시겠습니까?"
            } else {
                message.text = ""
            }
        }
    }
    
    func manageLoadData(collection: UICollectionView, completion: @escaping (ManageListModel) -> ()) {
        guard let userID = Auth.auth().currentUser?.email else {return}
        
        self.db.collection(userID).getDocuments { (querySnapshot, err) in
            for document in querySnapshot!.documents {
                if document.documentID != "UserData" {
                    self.mlM.dbID.append(document.documentID)
                    self.mlM.titles.append(document.data()["Title"] as! String)
                    self.mlM.firstDates.append((document["Dates"] as! [String]).sorted(by: <).first!)
                    self.mlM.lastDates.append((document["Dates"] as! [String]).sorted(by: <).last!)
                }
            }
            completion(self.mlM)
            collection.reloadData()
        }
    }
}

//MARK: Img Setting
extension DataService {
    func setImg(userImg: UIImageView) {
        guard let userID = Auth.auth().currentUser?.email else {return}
        
        self.db.collection(userID).document("UserData").addSnapshotListener { (document, err) in
            if err == nil {
                if document!["Profile"] as! String != "" {
                    let img = document!["Profile"] as! String
                    Storage.storage().reference(forURL: img).downloadURL { (url, error) in
                        if url != nil {
                            userImg.sd_setImage(with: url!, completed: nil)
                        } else {
                            print("SetImg url err: \(error!)")
                        }
                    }
                }
            }
        }
    }
    
    func pDSetImg(img: UIImageView, imgUrl: String) {
        if imgUrl != "" {
            Storage.storage().reference(forURL: imgUrl).downloadURL { (url, error) in
                if url != nil {
                    img.sd_setImage(with: url!, completed: nil)
                } else {
                    print("pDsetImg Load err: \(error!)")
                }
            }
        }
    }
}

//MARK: Change Account
extension DataService {
    func changeNick(reChangeNick: String) {
        guard let userID = Auth.auth().currentUser?.email else {return}
        
        let path = self.db.collection(userID).document("UserData")
        
        path.updateData(["UserName": reChangeNick])
        print("Change Nick")
    }
    
    func checkPWD(currentPWD: String, complection: @escaping(String) -> ()){
        guard let userID = Auth.auth().currentUser?.email else {return}
        
        self.db.collection(userID).document("UserData").getDocument { (document, err) in
            if let err = err {
                print("checkPWD err: \(err)")
            } else {
                let pwd = document!["password"] as! String
                if currentPWD == pwd {
                    complection("true")
                } else {
                    complection("false")
                }
            }
        }
    }
    
    func changePWD(changePWD: String, vc: UIViewController) {
        Auth.auth().currentUser?.updatePassword(to: changePWD) { error in
            if error == nil {
                print("ChangePWD Success")
                guard let userID = Auth.auth().currentUser?.email else { return }
                let path = self.db.collection(userID).document("UserData")
                path.updateData(["password": changePWD])
                
                AlertService().checkAlert(message: "비밀번호 변경 성공", vc: vc)
            }
        }
    }
    
    func logout(view: UIView) {
        try? Auth.auth().signOut()
        view.window?.rootViewController?.dismiss(animated: false, completion: {
            let loginView = LoginVC()
            loginView.modalPresentationStyle = .fullScreen
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController?.present(loginView, animated: true)
            print("LogOut")
        })
    }
    
    func updatePlanName(dbID: String, newTitle: String) {
        guard let userID = Auth.auth().currentUser?.email else {return}
        self.db.collection(userID).document(dbID).updateData(["Title": newTitle])
    }
    
    func removePlan(dbID: String) {
        guard let userID = Auth.auth().currentUser?.email else {return}
        self.db.collection(userID).document(dbID).delete()
    }
}
