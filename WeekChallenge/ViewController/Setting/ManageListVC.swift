//
//  ManageListVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/24.
//

import UIKit

class ManageListVC: UIViewController, UIGestureRecognizerDelegate {

    var mlM = ManageListModel()
    var mlVM = ManageListViewModel()
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var xButton: UIImageView!
    @IBOutlet weak var manageCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setUp() {
        ApplyService().onlyCornerApply(view: mainView)
        ApplyService().imgApplyLayer(img: xButton)
        
        let tap = UIGestureRecognizer(target: self, action: #selector(xButtonTap(sender:)))
        tap.delegate = self
        xButton.addGestureRecognizer(tap)
    }
    
    @objc func xButtonTap(sender: UIGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
    func loadData() {
        DataService().manageLoadData(collection: manageCollection) { model in
            self.mlM = model
        }
    }
}

//MARK: CollectionView DataSource
extension ManageListVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mlVM.numberOfItems(mlM: mlM)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = manageCollection.dequeueReusableCell(withReuseIdentifier: "manageCell", for: indexPath) as! ManageCell
        cell.mainTitle.text = mlVM.numberOfTitles(mlM: mlM, index: indexPath.row)
        cell.subTitle.text = mlVM.numberOfTitles(mlM: mlM, index: indexPath.row)
        cell.period.text = mlVM.numberOfDates(mlM: mlM, index: indexPath.row)
        
        cell.updateBtn.tag = indexPath.row
        cell.removeBtn.tag = indexPath.row
        
        cell.updateBtn.addTarget(self, action: #selector(changeBtn), for: .touchUpInside)
        cell.removeBtn.addTarget(self, action: #selector(removeBtn), for: .touchUpInside)
        
        return cell
    }
    
    @objc func changeBtn(sender: UIButton) {
        AlertService().updatePlan(view: self, dbID: mlVM.numberOfID(mlM: mlM, index: sender.tag))
    }
    
    @objc func removeBtn(sender: UIButton) {
        AlertService().deletePlan(view: self, message: mlVM.numberOfTitles(mlM: mlM, index: sender.tag), dbID: mlVM.numberOfID(mlM: mlM, index: sender.tag))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height/2)
    }
}

class ManageCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var period: UILabel!
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var removeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ApplyService().onlyCornerApply(view: backView)
        ApplyService().onlyCornerApply(view: totalView)
        ApplyService().applyManageCellShadow(cell: self)
    }
}

