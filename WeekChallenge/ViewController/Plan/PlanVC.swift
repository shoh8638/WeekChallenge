//
//  PlanVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/16.
//

import UIKit

class PlanVC: UIViewController {
    var pVM: PlanViewModel!
    
    @IBOutlet weak var listCollection: UICollectionView!
    @IBOutlet weak var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectService().Network(view: self)
        loadData()
        btn.isHidden = true
    }
    
    func loadData() {
        LayoutService().btnShadowApplt(btn: btn)
        DataService().PlanLoadData(collection: listCollection) { model in
            self.pVM = PlanViewModel(planM: model)
        }
    }
    
    @IBAction func btn(_ sender: Any) {
        listCollection.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
    }
}

//MARK: CollectionViewDataSource
extension PlanVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if pVM != nil {
            if pVM.numberOfRowsInSection() == 0 {
                return 1
            } else {
                return pVM.numberOfRowsInSection()
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if pVM.numberOfRowsInSection() == 0 {
            let cell = listCollection.dequeueReusableCell(withReuseIdentifier: "list", for: indexPath) as! PlanVCCell
            cell.emptyUpdate()
            return cell
        } else {
            let cell = listCollection.dequeueReusableCell(withReuseIdentifier: "list", for: indexPath) as! PlanVCCell
            let data = pVM.numberOfCellIndex(index: indexPath.row)
            cell.update(info: data, index: indexPath.row)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("PlanVC cell Select")
        if pVM.planM.isEmpty {
            AlertService().basicAlert(viewController: self, message: "????????? ??????????????????!")
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Ex") as! PlanDetailVC
            vc.documentID = pVM.numberOfDBID(index: indexPath.row)
            vc.mainTitle  = pVM.numberOfTitle(index: indexPath.row)
            vc.dates = pVM.numberOfTotalDate(index: indexPath.row)
            vc.transitioningDelegate = self
            vc.modalPresentationStyle = .custom
            
            self.present(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 75, height: UIScreen.main.bounds.height/2)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.pVM.numberOfRowsInSection() > 1 {
            if scrollView.contentOffset.x < 0 {
                self.btn.isHidden = false
            } else if scrollView.contentOffset.x == 0 {
                self.btn.isHidden = true
            } else {
                self.btn.isHidden = false
            }
        }
    }
}

//MARK: Animation
extension PlanVC: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(originFrame: self.listCollection.frame)
    }
}
