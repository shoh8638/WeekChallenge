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
    let db = Firestore.firestore()
    //MARK: 기존 DB생성
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
    
    func planFive(current: String) -> [String: String] {
        let fomatter = DateFormatter()
        fomatter.dateFormat = "yyy-MM-dd"
        let currentData = fomatter.date(from: current)!
        var fiveDateFomtter: [String: String] = [:]
        
        for i in 0...4 {
            let date1 = fomatter.string(from: Calendar.current.date(byAdding: .day, value: i, to: currentData)!)
            fiveDateFomtter.updateValue("", forKey: date1)
        }
        return fiveDateFomtter
    }
    
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
    func PlanLoadData(collection: UICollectionView ,completion: @escaping ([PlanModel?]) -> ()) {
        var complete = [Int]()
        
        guard let userID = Auth.auth().currentUser?.email else {return}
        
        var planM: PlanModel?
        var planVM = [planM]
        
        self.db.collection(userID).addSnapshotListener {(querySnapshot, err) in
            planVM.removeAll()
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
                        planM = PlanModel(title: title, dates: dates, dbID: dbID, firstDate: firstDate, lastDate: lastDate!, complete: complete)
                        planVM.append(planM!)
                    }
                    complete.removeAll()
                }
            }
            completion(planVM)
            collection.reloadData()
        }
    }
    
    func planDetailLoadData(collection: UICollectionView, documentID: String, completion: @escaping ([PDetailModel?]) -> ()) {
        guard let userID = Auth.auth().currentUser?.email else {return}
        var pdM: PDetailModel?
        var pdVM = [pdM]
        self.db.collection(userID).document(documentID).addSnapshotListener { (document, err) in
            pdVM.removeAll()
            if err == nil {
                let dates = (document!["Dates"] as! [String]).sorted(by: <)
                for number in 0...dates.count-1 {
                    let dateFields = document![dates[number]] as! [String: String]
                    let title = dateFields["Title"]!
                    let img = dateFields["Image"]!
                    let text = dateFields["Text"]!
                    if title != "" {
                        pdM = PDetailModel(title: title, img: img, text: text, planDate: dates)
                        pdVM.append(pdM)
                    }
                }
            }
            completion(pdVM)
            collection.reloadData()
        }
    }
    
    //DashBoard
    func TotalImgLoadData(collection: UICollectionView, completion: @escaping ([TotalModel?]) -> ()) {
        var dbM: TotalModel?
        var dbVM = [dbM]
        guard let userID = Auth.auth().currentUser?.email else {return}
        self.db.collection(userID).addSnapshotListener{ (querySnapshot, err) in
            dbVM.removeAll()
            for document in querySnapshot!.documents {
                if document.documentID != "UserData" {
                    let dbID = document.documentID
                    let title = document.data()["Title"] as! String
                    
                    let dates = (document["Dates"] as! [String]).sorted(by: <)
                    for i in 0...dates.count-1 {
                        let dateFields = document[dates[i]] as! [String: String]
                        let userTitle = dateFields["Title"]!
                        let userImg = dateFields["Image"]!
                        let userText = dateFields["Text"]!
                        if userTitle != "" && userImg != "" && userText != "" {
                            dbM = TotalModel(dbID: dbID, title: title, userTitle: userTitle, userImg: userImg, userText: userText, textDate: dates[i])
                            dbVM.append(dbM!)
                        }
                    }
                }
            }
            completion(dbVM)
            collection.reloadData()
        }
    }
    
    func totalDetailLoadData(collection: UICollectionView, documentID: String, text: String, date: String, completion: @escaping (TotalDeatilModel?) -> ()) {
        guard let userID = Auth.auth().currentUser?.email else {return}
        var tDM: TotalDeatilModel?
        self.db.collection(userID).document(documentID).addSnapshotListener { (document, err) in
            if err == nil {
                
                let dateFields = document![date] as! [String: String]

                    let title = dateFields["Title"]!
                    let img = dateFields["Image"]!
                    let text = dateFields["Text"]!
                    tDM = TotalDeatilModel(userTitle: title, userImg: img, userText: text)
                
            }
            completion(tDM)
            collection.reloadData()
        }
    }
    
    func searchLoadData(searchText: String, collection: UICollectionView, completion: @escaping ([TotalModel?]) -> ()) {
        
        guard let userID = Auth.auth().currentUser?.email else {return}
        var dbM: TotalModel?
        var dbVM = [dbM]
        self.db.collection(userID).getDocuments { (querySnapshot, err) in
            dbVM.removeAll()
            for document in querySnapshot!.documents {
                if document.documentID != "UserData" {
                    let dbID = document.documentID
                    let dates = (document["Dates"] as! [String]).sorted(by: <)
                    for i in 0...dates.count-1 {
                        let dateFields = document[dates[i]] as! [String: String]
                        let title = dateFields["Title"]!
                        let img = dateFields["Image"]!
                        let text = dateFields["Text"]!
                        if text.contains(searchText) {
                            dbM = TotalModel(dbID: dbID, title: "", userTitle: title, userImg: img, userText: text, textDate: "")
                            dbVM.append(dbM)
                        }
                    }
                }
            }
            completion(dbVM)
            collection.reloadData()
        }
    }
    
    func manageLoadData(collection: UICollectionView, completion: @escaping ([ManageModel?]) -> ()) {
        guard let userID = Auth.auth().currentUser?.email else {return}
        var manageM: ManageModel?
        var manageVM = [manageM]
        self.db.collection(userID).getDocuments { (querySnapshot, err) in
            manageVM.removeAll()
            for document in querySnapshot!.documents {
                if document.documentID != "UserData" {
                    let dbID = document.documentID
                    let title = document.data()["Title"] as! String
                    let firstDate = (document["Dates"] as! [String]).sorted(by: <).first!
                    let lastDate = (document["Dates"] as! [String]).sorted(by: <).last!
                    manageM = ManageModel(title: title, dbID: dbID, firstDate: firstDate, lastDate: lastDate)
                    manageVM.append(manageM!)
                }
            }
            completion(manageVM)
            collection.reloadData()
        }
    }
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
                    userName.text = "Hello! \(username)"
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
