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
        findData()
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
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

extension SearchVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.userTitles.count == 0 {
            return 1
        } else {
            return self.userTitles.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.userTitles.count == 0 {
            let cell = searchCollection.dequeueReusableCell(withReuseIdentifier: "enptyCell", for: indexPath) as! EnptyCollectionViewCell
            cell.vc = self
            return cell
        } else {
            let cell = searchCollection.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as! searchCell
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
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        
    }
}




class searchCell: UICollectionViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var text: UILabel!
}

