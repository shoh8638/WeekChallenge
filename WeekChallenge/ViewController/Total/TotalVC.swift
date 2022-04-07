//
//  TotalVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/18.
//

import UIKit
import TRMosaicLayout

class TotalVC: UIViewController, UIViewControllerTransitioningDelegate {
    
    let mosaicLayout = TRMosaicLayout()
    var totalVM: TotalViewModel!
    
    @IBOutlet weak var dashCollection: UICollectionView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var listTop: NSLayoutConstraint!
    @IBOutlet weak var searchTap: UIButton!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var cc: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listTop.constant = -40
        self.dashCollection?.collectionViewLayout = mosaicLayout
        mosaicLayout.delegate = self
        
        searchField.delegate = self
        searchView.isHidden = true
        searchButton.isHidden = true
        
        LayoutService().buttonCornerApply(btn: searchTap)
        loadData()
    }
    
    func loadData() {
        DataService().TotalImgLoadData(collection: dashCollection) { model in
            self.totalVM = TotalViewModel(totalM: model)
            if self.totalVM.numberOfRowsInSection() == 0 {
                self.searchTap.isHidden = true
                self.cc.isHidden = false
            } else {
                self.searchTap.isHidden = false
                self.cc.isHidden = true
            }
        }
    }
    
    @IBAction func searchButton(_ sender: Any) {
        if self.searchField.text != "" {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "exSearch") as! SearchVC
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            vc.searchText = self.searchField.text!
            self.present(vc, animated: true, completion: nil)
            self.searchField.text = ""
            self.searchView.isHidden = true
            self.searchView.alpha = 0
            self.searchButton.isHidden = true
            self.listTop.constant = -40
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func mainSearch(_ sender: Any) {
        print("Tap")
        if searchView.isHidden == true {
            UIView.animate(withDuration: 0.5, animations: {
                self.searchView.isHidden = false
                self.searchView.alpha = 1
                self.listTop.constant = 5
                self.view.layoutIfNeeded()
                self.dashCollection.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
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
}

extension TotalVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if searchField.text!.count > 0 {
            searchButton.isHidden = false
        } else {
            searchButton.isHidden = true
        }
        return true
    }
}

//MARK: CollectionView DataSource
//TODO: 각 셀 터치 시, 디테일 화면 생성
extension TotalVC: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if totalVM != nil {
            return self.totalVM.numberOfRowsInSection()
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if totalVM.numberOfRowsInSection() != 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "total", for: indexPath) as! totalCell
            cell.layer.cornerRadius = 20
            totalVM.totalUseImg(index: indexPath.row, img: cell.img)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if totalVM.numberOfRowsInSection() != 0 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "totalDetail") as! TotalDetailVC
            vc.documnetID = totalVM.numberOfDocumentID(index: indexPath.row)
            vc.userText = totalVM.numberOfTitle(index: indexPath.row)
            vc.date = totalVM.numberOfDate(index: indexPath.row)
            
            vc.modalPresentationStyle = .overFullScreen
            
            self.present(vc, animated: true)
        }
    }
}

//MARK: CollectionView Layout
extension TotalVC: TRMosaicLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, mosaicCellSizeTypeAtIndexPath indexPath: IndexPath) -> TRMosaicCellType {
        return indexPath.item % 3 == 0 ? TRMosaicCellType.big : TRMosaicCellType.small
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout: TRMosaicLayout, insetAtSection:Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func heightForSmallMosaicCell() -> CGFloat {
        return self.dashCollection.bounds.height / 4
    }
}
