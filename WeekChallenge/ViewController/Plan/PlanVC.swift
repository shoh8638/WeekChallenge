//
//  PlanVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/16.
//

import UIKit
import Firebase
import LSHContributionView

class PlanVC: UIViewController {
    
    let db = Firestore.firestore()
    var countList: Int = 0
    var dbID = [String]()
    var dbTitles = [String]()
    var dbDate = [[Int]]()
    var firstDates = [String]()
    var lastDates = [String]()
    
    @IBOutlet weak var listCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Connectivity().Network(view: self)
        loadData()
        initRefresh()
    }
    
    func loadData() {
        var complete = [Int]()
        guard let userID = Auth.auth().currentUser?.email else {return}
        self.db.collection(userID).addSnapshotListener {(querySnapshot, err) in
            self.dbID.removeAll()
            self.dbTitles.removeAll()
            self.dbDate.removeAll()
            if err == nil {
                for document in querySnapshot!.documents {
                    if document.documentID != "UserData" {
                        self.dbID.append(document.documentID)
                        self.dbTitles.append(document.data()["Title"] as! String)
                        
                        let first = (document["Dates"] as! [String]).sorted(by: <).first!
                        let last = (document["Dates"] as! [String]).sorted(by: <).last!
                        
                        self.firstDates.append(first)
                        self.lastDates.append(last)
                        
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
                        self.dbDate.append(complete)
                        complete.removeAll()
                    }
                }
            }
            self.listCollection.reloadData()
        }
    }
    
    func initRefresh() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(updateUI(refresh:)), for: .valueChanged)
        refresh.attributedTitle = NSAttributedString(string: "새로고침")
        self.listCollection.refreshControl = refresh
    }
    
    @objc func updateUI(refresh: UIRefreshControl) {
        self.dbID.removeAll()
        self.dbTitles.removeAll()
        self.dbDate.removeAll()
        loadData()
        refresh.endRefreshing()
    }
}

extension PlanVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.dbID.count == 0 {
            return 1
        } else if !self.dbTitles.isEmpty {
            return self.dbTitles.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.dbID.count == 0 {
            let cell = listCollection.dequeueReusableCell(withReuseIdentifier: "list", for: indexPath) as! listCell
            applyShadow(cell: cell, color: UIColor.black.cgColor, alpha: 0.14, x: 10, y: 0, blur: 7)
            cell.backView.layer.cornerRadius = 20
            cell.backView.layer.masksToBounds = true
            
            cell.secondView.layer.cornerRadius = 20
            cell.secondView.layer.masksToBounds = true
            
            cell.title.text = "플랜을 생성해주세요!"
            cell.subTitle.text = ""
            cell.period.text = ""
            return cell
        } else {
            
            let cell = listCollection.dequeueReusableCell(withReuseIdentifier: "list", for: indexPath) as! listCell
            applyShadow(cell: cell, color: UIColor.black.cgColor, alpha: 0.14, x: 10, y: 0, blur: 7)
            cell.backView.layer.cornerRadius = 20
            cell.backView.layer.masksToBounds = true
            
            cell.secondView.layer.cornerRadius = 20
            cell.secondView.layer.masksToBounds = true
            
            cell.title.text = self.dbTitles[indexPath.row]
            cell.subTitle.text = self.dbTitles[indexPath.row]
            cell.period.text = "\(self.firstDates[indexPath.row]) ~ \(self.lastDates[indexPath.row])"
            LSHViewChange(view: cell.LSHView, count: self.dbDate[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("cellTouch")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Ex")
        
        vc?.transitioningDelegate = self
        vc?.modalPresentationStyle = .custom
        self.present(vc!, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height/2)
    }
    
    func LSHViewChange(view: UIView, count: Array<Int>) {
        if count != [] {
            let dataSquare = [count]
            let contributeView = LSHContributionView(frame: CGRect(x:0, y: 0, width: view.bounds.width, height: view.bounds.height))
            
            contributeView.data = dataSquare
            contributeView.colorScheme = "Halloween"
            view.addSubview(contributeView)
        }
    }
    
    func applyShadow(cell: listCell,color: CGColor, alpha: Float, x: Int, y: Int, blur: CGFloat) {
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = color
        cell.layer.shadowOpacity = alpha
        cell.layer.shadowOffset = CGSize(width: x, height: y)
        cell.layer.shadowRadius = blur / 2.0
    }
}

extension PlanVC: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(originFrame: self.listCollection.frame)
    }
}
