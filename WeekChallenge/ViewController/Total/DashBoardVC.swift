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

//컨테이너뷰 2개 넣고 맨처음에는 컬렉션뷰
//검색누르면 컬렉션뷰 히든 -> 검색view
//취소 누르면 검색view 히든 -> 컬렉션뷰
class DashBoardVC: UIViewController {
    
    let db = Firestore.firestore()
    var dbID = [String]()
    var dbTitles = [String]()
    var userTitles = [String]()
    var userImg = [String]()
    var userText = [String]()
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var stack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectService().Network(view: self)
        loadData()
        initRefresh()
        searchView.isHidden = true
    }
    
    @IBAction func settingButton(_ sender: Any) {
    }
    
    @IBAction func searchBtn(_ sender: Any) {
        if searchView.isHidden == true {
            UIView.animate(withDuration: 0.5, animations: {
                self.searchView.isHidden = false
                self.searchView.alpha = 1
            })
        } else if searchView.isHidden == false {
            UIView.animate(withDuration: 0.5, animations: {
                self.searchView.isHidden = true
                self.searchView.alpha = 0
            })
        }
    }
    @IBAction func searchButton(_ sender: Any) {
        if self.searchText.text != "" {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "searchVC") as! SearchVC
            vc.searchText = self.searchText.text!
            self.present(vc, animated: true, completion: nil)
            self.searchText.text = ""
        }
    }
    
    func loadData() {
        guard let userID = Auth.auth().currentUser?.email else {return}
        self.db.collection(userID).addSnapshotListener{ (querySnapshot, err) in
            for document in querySnapshot!.documents {
                if document.documentID != "UserData" {
                    self.dbID.append(document.documentID)
                    self.dbTitles.append(document.data()["Title"] as! String)
                    
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
        if self.userTitles.count == 0 {
            return 1
        } else {
            return self.userTitles.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.userTitles.count == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "enptyCell", for: indexPath) as! EnptyCollectionViewCell
            cell.vc = self
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "total", for: indexPath) as! totalCell
            Storage.storage().reference(forURL: self.userImg[indexPath.row]).downloadURL { (url, error) in
                if url != nil {
                    cell.img.sd_setImage(with: url!, completed: nil)
                } else {
                 print("DashBoardVC err: \(error!)")
                }
            }
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
