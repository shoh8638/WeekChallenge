//
//  TotalDetailVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/04/01.
//

import UIKit

class TotalDetailVC: UIViewController, UIGestureRecognizerDelegate {
    
    var documnetID: String?
    var userText: String?
    var date: String?
    var tdVM: TotalDetailViewModel!
    
    @IBOutlet weak var tdCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    @IBAction func back(_ sender: UIGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
    func loadData() {
        DataService().totalDetailLoadData(collection: tdCollection, documentID: documnetID!, text: userText!, date: date!) { model in
            self.tdVM = TotalDetailViewModel(tDetailM: model)
        }
    }
}

extension TotalDetailVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if tdVM != nil {
            return 1
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(indexPath.row)
        let cell = tdCollection.dequeueReusableCell(withReuseIdentifier: "tdCell", for: indexPath) as! TotalDetailCell
        print(indexPath.row)
        cell.update(info: tdVM.numberOfCellIndex()!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return tdVM.heightOfCell(collection: tdCollection)
    }
}
