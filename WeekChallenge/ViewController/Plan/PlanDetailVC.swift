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
    
    var documentID: String?
    var mainTitle: String?
    var pdVM: PDetailViewModel!
    
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
        DataService().planDetailLoadData(collection: DetatilCollection, documentID: self.documentID!) { model in
            self.pdVM = PDetailViewModel(pDeatilM: model)
        }
    }
}


extension PlanDetailVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.pdVM != nil {
            if pdVM.numberOfRowsInSection() == 0 {
                return 1
            } else {
                return pdVM.numberOfRowsInSection()
            }
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if pdVM.numberOfRowsInSection() == 0 {
            let cell = DetatilCollection.dequeueReusableCell(withReuseIdentifier: "detailList", for: indexPath) as! PlanDetailVCCell
            cell.emptyUpdate()
            return cell
        } else {
            let cell = DetatilCollection.dequeueReusableCell(withReuseIdentifier: "detailList", for: indexPath) as! PlanDetailVCCell
            let data = pdVM.numberOfCellIndex(index: indexPath.row)
            cell.update(info: data, url: pdVM.numberOfImg(index: indexPath.row))
            
            
            
//            Storage.storage().reference(forURL: pdVM.numberOfImg(index: indexPath.row)).downloadURL { (url, error) in
//                if url != nil {
//                    cell.imageView.sd_setImage(with: url!, completed: nil)
//                } else {
//                    print("PDetailViewModel url err: \(error!)")
//                }
//            }
            return cell
        }
    }
}
