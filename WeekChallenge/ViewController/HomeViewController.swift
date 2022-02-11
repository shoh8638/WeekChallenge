//
//  HomeViewController.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/10.
//

import UIKit
import SnapKit
import SwiftOverlays

class HomeViewController: UIViewController {
    let arr: Array<String> = []
    
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var hiddenView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var emptyView : EmptyView = {
        let view = EmptyView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        if arr.count != 0 {
            self.homeView.addSubview(emptyView)
            emptyView.snp.remakeConstraints { maker in
                maker.edges.equalToSuperview()
            }
            self.emptyView.mainButton.addTarget(self, action: #selector(Click), for: .touchUpInside)
        } else {
        }
    }
    @objc func Click(sender: UIButton? = nil) {
        print("Tap")
    }
    @IBAction func expandBtn(_ sender: Any) {
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Cell
        cell.backgroundColor = .black
        return cell
    }    
}

class Cell: UICollectionViewCell {
    
}
