//
//  ManageListVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/24.
//

import UIKit

class ManageListVC: UIViewController, UIGestureRecognizerDelegate {

    var manageVM: ManageViewModel!

    @IBOutlet weak var manageCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func setUp() {
        let tap = UIGestureRecognizer(target: self, action: #selector(xButtonTap(sender:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func xButtonTap(sender: UIGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
    func loadData() {
        DataService().manageLoadData(collection: manageCollection) { model in
            self.manageVM = ManageViewModel(manageM: model)
        }
    }
}

//MARK: CollectionView DataSource
extension ManageListVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if manageVM != nil {
            if manageVM.numberOfRowsInSection() == 0 {
                return 1
            } else {
                return manageVM.numberOfRowsInSection()
            }
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if manageVM.numberOfRowsInSection() == 0 {
            let cell = manageCollection.dequeueReusableCell(withReuseIdentifier: "manageCell", for: indexPath) as! ManageCell
            cell.emptyCell()
            return cell
        } else {
            let cell = manageCollection.dequeueReusableCell(withReuseIdentifier: "manageCell", for: indexPath) as! ManageCell
            let data = manageVM.numberOfCellIndex(index: indexPath.row)
            cell.update(info: data)
            
            cell.updateBtn.tag = indexPath.row
            cell.removeBtn.tag = indexPath.row
            
            cell.updateBtn.addTarget(self, action: #selector(changeBtn), for: .touchUpInside)
            cell.removeBtn.addTarget(self, action: #selector(removeBtn), for: .touchUpInside)
            
            return cell
        }
    }
    
    @objc func changeBtn(sender: UIButton) {
        AlertService().updatePlan(view: self, dbID: manageVM.numberOfDBID(index: sender.tag))
    }
    
    @objc func removeBtn(sender: UIButton) {
        AlertService().deletePlan(view: self, message: manageVM.numberOfTitle(index: sender.tag), dbID: manageVM.numberOfDBID(index: sender.tag))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/2-20, height: UIScreen.main.bounds.height/4)
    }
}

class ManageCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainSubView: UIView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var period: UILabel!
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var removeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        LayoutService().onlyCornerApply(view: totalView)
        LayoutService().onlyCornerApply(view: mainView)
        LayoutService().onlyCornerApply(view: mainSubView)
        LayoutService().applyManageCellShadow(cell: self)
    }
    
    func update(info: ManageModel) {
        mainTitle.text = info.title
        subTitle.text = info.title
        period.text = "\(info.firstDate!) ~ \(info.lastDate!)"
    }
    
    func emptyCell() {
        mainTitle.text = "플랜이 없습니다"
        subTitle.text = ""
        period.text = ""
    }
}

