//
//  DetailListVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/17.
//

import UIKit
import Firebase
import SwiftOverlays
import SDWebImage

class DetailListVC: UIViewController {
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    var documentID: String?
    var mainTitle: String?
    
    var subTitles = [String]()
    var subImg = [String]()
    var subText = [String]()
    
    @IBOutlet weak var DetatilCollection: UICollectionView!
    @IBOutlet weak var documentTitle: UILabel!
    @IBOutlet weak var detailView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectService().Network(view: self)
        documentTitle.text = mainTitle!
        detailView.layer.cornerRadius = 20
        detailView.layer.masksToBounds = true
        loadData()
    }
    
    @IBAction func btn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func addbtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "writeVC") as! WriteVC
        vc.documentID = self.documentID!
        vc.titles = self.mainTitle!
        self.present(vc, animated: true)
    }
    
    func loadData() {
        guard let userID = Auth.auth().currentUser?.email else { return }
        db.collection(userID).document(documentID!).addSnapshotListener { (document, err) in
            self.subTitles.removeAll()
            self.subImg.removeAll()
            self.subText.removeAll()
            
            if err == nil {
                let dates = (document!["Dates"] as! [String]).sorted(by: <)
                for number in 0...dates.count-1 {
                    let dateFields = document![dates[number]] as! [String: String]
                    let title = dateFields["Title"]!
                    let img = dateFields["Image"]!
                    let text = dateFields["Text"]!
                    if title != "" {
                        self.subTitles.append(title)
                        self.subImg.append(img)
                        self.subText.append(text)
                    }
                }
            }
            self.DetatilCollection.reloadData()
        }
    }
    
    func applyShadow(cell: detailList,color: CGColor, alpha: Float, x: Int, y: Int, blur: CGFloat) {
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = color
        cell.layer.shadowOpacity = alpha
        cell.layer.shadowOffset = CGSize(width: x, height: y)
        cell.layer.shadowRadius = blur / 2.0
    }
}


extension DetailListVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.subTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = DetatilCollection.dequeueReusableCell(withReuseIdentifier: "detailList", for: indexPath) as! detailList
        cell.backView.layer.cornerRadius = 20
        cell.backView.layer.masksToBounds = true
        
        cell.totalView.layer.cornerRadius = 20
        cell.totalView.layer.masksToBounds = true
        
        applyShadow(cell: cell, color: UIColor.black.cgColor, alpha: 0.14, x: 10, y: 0, blur: 7)
        self.storage.reference(forURL: self.subImg[indexPath.row]).downloadURL { (url, error) in
            if url != nil {
                cell.imageView.sd_setImage(with: url!, completed: nil)
                
            } else {
                print("DashBoardVC err: \(error!)")
            }
        }
        cell.mainTitle.text = self.subTitles[indexPath.row]
        cell.mainText.text = self.subText[indexPath.row]
        return cell
    }
}

class detailList: UICollectionViewCell {
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var mainText: UILabel!
}
