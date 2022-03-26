//
//  SearchVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/03.
//

import UIKit

class SearchVC: UIViewController {
    
    var searchText: String?
    var totalVM: TotalViewModel!
    
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
            self.totalVM = TotalViewModel(totalM: model)
        }
    }
}

extension SearchVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if totalVM != nil {
            if self.totalVM.numberOfRowsInSection() == 0 {
                return 1
            } else {
                return self.totalVM.numberOfRowsInSection()
            }
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if totalVM.numberOfRowsInSection() == 0 {
            let cell = searchCollection.dequeueReusableCell(withReuseIdentifier: "cellTwo", for: indexPath) as! searchCell
            cell.emptyCell()
            return cell
        } else {
            let cell = searchCollection.dequeueReusableCell(withReuseIdentifier: "cellTwo", for: indexPath) as! searchCell
            let data = self.totalVM.numberOfCellIndex(index: indexPath.row)
            cell.update(info: data, index: indexPath.row)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return totalVM.heightOfCell(collection: searchCollection)
    }    
}
