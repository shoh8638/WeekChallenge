//
//  exDashVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/18.
//

import UIKit
import Firebase
import SDWebImage
import TRMosaicLayout
//검색 화면 나오고 검색 버튼 눌렀을 시, 알림창과 비슷하게 쭉 나오게 하기
class exDashVC: UIViewController {
    
    let mosaicLayout = TRMosaicLayout()
    let db = Firestore.firestore()
    var dbID = [String]()
    var dbTitles = [String]()
    var userTitles = [String]()
    var userImg = [String]()
    var userText = [String]()
    
    @IBOutlet weak var dashCollection: UICollectionView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var listTop: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listTop.constant = -40
        self.dashCollection?.collectionViewLayout = mosaicLayout
        mosaicLayout.delegate = self
        
        searchField.delegate = self
        searchView.isHidden = true
        searchButton.isHidden = true
        
        loadData()
    }
    
    func loadData() {
        guard let userID = Auth.auth().currentUser?.email else {return}
        self.db.collection(userID).addSnapshotListener{ (querySnapshot, err) in
            self.dbID.removeAll()
            self.dbTitles.removeAll()
            self.userTitles.removeAll()
            self.userImg.removeAll()
            self.userText.removeAll()
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
            self.dashCollection.reloadData()
        }
    }
    
    @objc func searchTap(sender: UITapGestureRecognizer) {
        print("Tap")
        if searchView.isHidden == true {
            UIView.animate(withDuration: 0.5, animations: {
                self.searchView.isHidden = false
                self.searchView.alpha = 1
                self.listTop.constant = 5
                self.view.layoutIfNeeded()
            })
        } else if searchView.isHidden == false {
            UIView.animate(withDuration: 0.5, animations: {
                self.searchView.isHidden = true
                self.searchView.alpha = 0
                self.listTop.constant = -40
                self.view.layoutIfNeeded()
            })
        }
    }
    //카드형식으로 나오게 하기
    @IBAction func searchButton(_ sender: Any) {
        if self.searchField.text != "" {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "searchVC") as! SearchVC
            vc.searchText = self.searchField.text!
            self.present(vc, animated: true, completion: nil)
            self.searchField.text = ""
            self.searchView.isHidden = true
            self.searchView.alpha = 0
            self.listTop.constant = -40
            self.view.layoutIfNeeded()
        }
    }
}

extension exDashVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if searchField.text!.count > 0 {
            searchButton.isHidden = false
        } else {
            searchButton.isHidden = true
        }
        return true
    }
}

extension exDashVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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
            if indexPath.row == 1 {
                let tapA = UITapGestureRecognizer(target: self, action: #selector(searchTap(sender:)))
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "total", for: indexPath) as! totalCell
                cell.layer.cornerRadius = 20
                applyShadow(cell: cell, color: UIColor.black.cgColor, alpha: 0.07, x: 10, y: 0, blur: 7)
                cell.addGestureRecognizer(tapA)
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "total", for: indexPath) as! totalCell
                cell.layer.cornerRadius = 20
                applyShadow(cell: cell, color: UIColor.black.cgColor, alpha: 0.07, x: 10, y: 0, blur: 7)
                Storage.storage().reference(forURL: self.userImg[indexPath.row]).downloadURL { (url, error) in
                    if url != nil {
                        cell.contentView.layer.cornerRadius = 20
                        cell.img.layer.cornerRadius = 20
                        cell.img.sd_setImage(with: url!, completed: nil)
                    } else {
                        print("DashBoardVC err: \(error!)")
                    }
                }
                return cell
            }
        }
    }
    
    func applyShadow(cell: totalCell,color: CGColor, alpha: Float, x: Int, y: Int, blur: CGFloat) {
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = color
        cell.layer.shadowOpacity = alpha
        cell.layer.shadowOffset = CGSize(width: x, height: y)
        cell.layer.shadowRadius = blur / 2.0
    }
}

extension exDashVC: TRMosaicLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, mosaicCellSizeTypeAtIndexPath indexPath: IndexPath) -> TRMosaicCellType {
        return indexPath.item % 3 == 0 ? TRMosaicCellType.big : TRMosaicCellType.small
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout: TRMosaicLayout, insetAtSection:Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func heightForSmallMosaicCell() -> CGFloat {
        return self.dashCollection.bounds.height / 3
    }
}
