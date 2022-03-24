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
    var dbM = DashBoardModel()
    var dbVM = DashBoardViewModel()
    
    @IBOutlet weak var searchCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectService().Network(view: self)
        loadData()
    }
    
    @IBAction func backTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadData() {
        DataService().searchLoadData(searchText: searchText!, collection: searchCollection) { model in
            self.dbM = model
        }
    }
}

extension SearchVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dbVM.numberOfItem(dbM: dbM)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchCollection.dequeueReusableCell(withReuseIdentifier: "cellTwo", for: indexPath) as! searchCell
        DataService().pDSetImg(img: cell.img, imgUrl: dbVM.numberOfImg(dbM: dbM, index: indexPath.row))
        cell.mainTitle.text = dbVM.numberOfTitle(dbM: dbM, index: indexPath.row)
        cell.mainText.text =  dbVM.numberOfText(dbM: dbM, index: indexPath.row)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.searchCollection.bounds.width - 100, height: self.searchCollection.bounds.height-200)
    }    
}
