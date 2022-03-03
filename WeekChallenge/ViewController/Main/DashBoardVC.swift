//
//  DashBoardVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/25.
//

import UIKit
import Firebase
import FirebaseStorage
import SDWebImage

class DashBoardVC: UIViewController {
    
    let db = Firestore.firestore()
    var dbID = [String]()
    var dbTitles = [String]()
    var userTitles = [String]()
    var userImg = [String]()
    var userText = [String]()
    
    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        initRefresh()
    }
    
    @IBAction func settingButton(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppSetting") as! SettingVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func loadData() {
        guard let userID = Auth.auth().currentUser?.email else {return}
        self.db.collection(userID).getDocuments { (querySnapshot, err) in
            for document in querySnapshot!.documents {
                if document.documentID != "UserData" {
                    self.dbID.append(document.documentID)
                    let range = document.documentID.firstIndex(of: "+") ?? document.documentID.endIndex
                    self.dbTitles.append(String(document.documentID[..<range]))
                    
                    let dates = (document["Dates"] as! [String]).sorted(by: <)
                    for i in 0...dates.count-1 {
                        let dateFields = document[dates[i]] as! [String: String]
                        let title = dateFields["Title"]!
                        let img = dateFields["Image"]!
                        let text = dateFields["Text"]!
                        if title != "" && img != "" && text != "" {
                            self.userTitles.append(title)
                            self.userImg.append(img)
                            self.userText.append(text)
                        }
                    }
                }
            }
            self.collection.reloadData()
        }
    }
    func initRefresh() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(updateUI(refresh:)), for: .valueChanged)
        refresh.attributedTitle = NSAttributedString(string: "새로고침")
        
        if #available(iOS 10.0, *) {
            self.collection.refreshControl = refresh
        } else {
            self.collection.addSubview(refresh)
        }
    }
    
    @objc func updateUI(refresh: UIRefreshControl) {
        self.dbID.removeAll()
        self.dbTitles.removeAll()
        self.userTitles.removeAll()
        self.userImg.removeAll()
        self.userText.removeAll()
        loadData()
        refresh.endRefreshing()
    }
}

extension DashBoardVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.dbTitles.count == 0 {
            return 1
        } else {
            return self.dbTitles.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.dbTitles.count == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "enptyCell", for: indexPath) as! EnptyCollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "total", for: indexPath) as! totalCell
            cell.name.text = self.dbTitles[indexPath.row]
            Storage.storage().reference(forURL: self.userImg[indexPath.row]).downloadURL { (url, error) in
                cell.img.sd_setImage(with: url!, completed: nil)
                    }
            cell.title.text = self.userTitles[indexPath.row]
            cell.text.text = self.userText[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.dbTitles.count == 0 {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        } else {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/3)
        }
    }
}

class totalCell: UICollectionViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var text: UILabel!
}

