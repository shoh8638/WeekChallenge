//
//  SearchVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/03.
//

import UIKit
import Firebase
import FirebaseStorage
import SDWebImage

class SearchVC: UIViewController {
    
    var searchText: String?
    var dbTitles = [String]()
    var userTitles = [String]()
    var userImg = [String]()
    var userText = [String]()
    let db = Firestore.firestore()
    

    @IBOutlet weak var searchCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectService().Network(view: self)
        findData()
    }
    
    @IBAction func backTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func findData() {
        guard let userID = Auth.auth().currentUser?.email else {return}
        if self.searchText != nil {
            self.db.collection(userID).getDocuments { (querySnapshot, err) in
                for document in querySnapshot!.documents {
                    if document.documentID != "UserData" {
                        let dates = (document["Dates"] as! [String]).sorted(by: <)
                        for i in 0...dates.count-1 {
                            let dateFields = document[dates[i]] as! [String: String]
                            let title = dateFields["Title"]!
                            let img = dateFields["Image"]!
                            let text = dateFields["Text"]!
                            if text.contains(self.searchText!) {
                                self.userTitles.append(title)
                                self.userImg.append(img)
                                self.userText.append(text)
                                
                                let range = document.documentID.firstIndex(of: "+") ?? document.documentID.endIndex
                                self.dbTitles.append(String(document.documentID[..<range]))
                            }
                        }
                    }
                }
                self.searchCollection.reloadData()
            }
        }
    }
}

extension SearchVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.userTitles.count == 0 {
            return 1
        } else {
            return self.userTitles.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.userTitles.count == 0 {
            let cell = searchCollection.dequeueReusableCell(withReuseIdentifier: "enptyCell", for: indexPath)
            return cell
        } else {
            let cell = searchCollection.dequeueReusableCell(withReuseIdentifier: "cellTwo", for: indexPath) as! searchCellTwo
            cell.backView.layer.cornerRadius = 20
            cell.backView.layer.masksToBounds = true
            
            cell.totalView.layer.cornerRadius = 20
            cell.totalView.layer.masksToBounds = true
            
            applyShadow(cell: cell, color: UIColor.black.cgColor, alpha: 0.14, x: 10, y: 0, blur: 7)
            Storage.storage().reference(forURL: self.userImg[indexPath.row]).downloadURL { (url, error) in
                cell.img.sd_setImage(with: url!, completed: nil)
            }
            cell.mainTitle.text = self.userTitles[indexPath.row]
            cell.mainText.text = self.userText[indexPath.row]
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.searchCollection.bounds.width - 100, height: self.searchCollection.bounds.height-200)
    }
    
    func applyShadow(cell: searchCellTwo,color: CGColor, alpha: Float, x: Int, y: Int, blur: CGFloat) {
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = color
        cell.layer.shadowOpacity = alpha
        cell.layer.shadowOffset = CGSize(width: x, height: y)
        cell.layer.shadowRadius = blur / 2.0
    }
}




class searchCell: UICollectionViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var text: UILabel!
}

class searchCellTwo: UICollectionViewCell {
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var mainText: UILabel!
}
