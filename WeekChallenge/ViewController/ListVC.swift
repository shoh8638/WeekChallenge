//
//  SubViewController.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/03.
//

import UIKit
import Firebase
import LSHContributionView
import VerticalCardSwiper
import SwiftOverlays

class ListVC: UIViewController {
    
    
    let db = Firestore.firestore()
    var countList: Int = 0
    var dbID = [String]()
    var dbTitles = [String]()
    var dbDate = [[Int]]()
    var cardSwiper: VerticalCardSwiper!
    
    @IBOutlet weak var mainView: VerticalCardSwiperView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Connectivity().Network(view: self)
        
        cardSetup()
        loadData()
        initRefresh()
    }
    
    func cardSetup() {
        cardSwiper = VerticalCardSwiper(frame:self.mainView.bounds)
        mainView.addSubview(cardSwiper)
        cardSwiper.isSideSwipingEnabled = false
        
        cardSwiper.datasource = self
        cardSwiper.delegate = self
        cardSwiper.register(nib: UINib(nibName: "PlanCardCell", bundle: nil), forCellWithReuseIdentifier: "PlanCardCell")
        cardSwiper.register(nib: UINib(nibName: "PlanEnptyCardCell", bundle: nil), forCellWithReuseIdentifier: "PlanEnptyCardCell")
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
            self.cardSwiper.reloadData()
        }
    }
    
    func initRefresh() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(updateUI(refresh:)), for: .valueChanged)
        refresh.attributedTitle = NSAttributedString(string: "새로고침")
        self.mainView.refreshControl = refresh
    }
    
    @objc func updateUI(refresh: UIRefreshControl) {
        self.dbID.removeAll()
        self.dbTitles.removeAll()
        self.dbDate.removeAll()
        loadData()
        refresh.endRefreshing()
    }
    
    @IBAction func settingButton(_ sender: Any) {
    }
    
    @IBAction func refresh(_ sender: Any) {
        self.showTextOverlay("새로고침중..")
        self.dbID.removeAll()
        self.dbTitles.removeAll()
        self.dbDate.removeAll()
        loadData()
        self.removeAllOverlays()
    }
    
}

extension ListVC: VerticalCardSwiperDatasource, VerticalCardSwiperDelegate{
    
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        if self.dbID.count == 0 {
            return 1
        } else if !self.dbTitles.isEmpty {
            return self.dbTitles.count
        } else {
            return 0
        }
    }
    
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        if self.dbID.count == 0 {
            let cell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "PlanEnptyCardCell", for: index) as! PlanEnptyCardCell
            cell.vc = self
            return cell
        } else {
            let cell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "PlanCardCell", for: index) as! PlanCardCell
            cell.backView.layer.cornerRadius = 20
            cell.backView.layer.masksToBounds = true

            if index % 2 == 0 {
                cell.backView.backgroundColor = UIColor(named: "cardColorOne")
            } else {
                cell.backView.backgroundColor = UIColor(named: "cardColorTwo")
            }
            cell.titleBtn.tintColor = .black
            cell.titleBtn.tag = index
            cell.documentID = self.dbID[index]
            cell.titles = self.dbTitles[index]
            cell.viewController = self
            cell.titleBtn.setTitle("\(self.dbTitles[index])", for: .normal)
            LSHViewChange(view: cell.LSHView, count: self.dbDate[index], index: index)
            return cell
        }
    }
    
    func LSHViewChange(view: UIView, count: Array<Int>, index: Int) {
        if count != [] {
            let dataSquare = [count]
            let contributeView = LSHContributionView(frame: CGRect(x:-25, y: 0, width: mainView.bounds.width-10, height: mainView.bounds.height))
            if index % 2 == 0 {
                contributeView.backgroundColor = UIColor(named: "cardColorOne")
            } else {
                contributeView.backgroundColor = UIColor(named: "cardColorTwo")
            }
            contributeView.data = dataSquare
            contributeView.colorScheme = "Halloween"
            view.addSubview(contributeView)
        }
    }
}