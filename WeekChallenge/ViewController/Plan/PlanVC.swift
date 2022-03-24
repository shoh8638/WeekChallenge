//
//  PlanVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/16.
//

import UIKit

class PlanVC: UIViewController {

    var planM = PlanModel()
    var planVM = PlanViewModel()
    
    @IBOutlet weak var listCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectService().Network(view: self)
        loadData()
    }
    
    func loadData() {
        DataService().pLoadData(collection: listCollection) { model in
            self.planM = model
        }
    }
}

//MARK: CollectionViewDataSource
extension PlanVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return planVM.numberOfItem(planM: planM)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = listCollection.dequeueReusableCell(withReuseIdentifier: "list", for: indexPath) as! PlanVCCell
        
        cell.title.text = planVM.numberOfTitle(planM: planM, index: indexPath.row)
        cell.subTitle.text = planVM.numberOfSubTitle(planM: planM, index: indexPath.row)
        cell.period.text = planVM.numberOfPeriod(planM: planM, index: indexPath.row)
        contributeView().LSHViewChange(view: cell.LSHView, count: planVM.numberOfDate(planM: planM, index: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("PlanVC cell Select")
        if self.planM.dbID != [String]() {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Ex") as! PlanDetailVC
            vc.documentID = self.planM.dbID[indexPath.row]
            vc.mainTitle  = self.planM.dbTitles[indexPath.row]
            
            vc.transitioningDelegate = self
            vc.modalPresentationStyle = .custom
            
            self.present(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height/2)
    }
}

//MARK: Animation
extension PlanVC: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(originFrame: self.listCollection.frame)
    }
}
