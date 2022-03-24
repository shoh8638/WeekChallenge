//
//  PlanDetailVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/17.
//

import UIKit
import Firebase
import SwiftOverlays
import SDWebImage

class PlanDetailVC: UIViewController {
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    var pDetailM = PlanDetailModel()
    let pDetailVM = PlanDetailViewModel()
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
        ApplyService().onlyCornerApply(view: detailView)
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
        DataService().pDLoadData(collection: DetatilCollection, documentID: documentID!) { model in
            self.pDetailM = model
        }
    }
}


extension PlanDetailVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pDetailVM.numberOfItem(pDeatilM: pDetailM)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = DetatilCollection.dequeueReusableCell(withReuseIdentifier: "detailList", for: indexPath) as! PlanDetailVCCell
        
        DataService().pDSetImg(img: cell.imageView, imgUrl: pDetailVM.numberOfImg(pDeatilM: pDetailM, index: indexPath.row))
        cell.mainTitle.text = pDetailVM.numberOfTitle(pDeatilM: pDetailM, index: indexPath.row)
        cell.mainText.text = pDetailVM.numberOfSubTitle(pDeatilM: pDetailM, index: indexPath.row)
        return cell
    }
}
