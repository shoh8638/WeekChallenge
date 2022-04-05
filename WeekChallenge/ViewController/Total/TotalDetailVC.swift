//
//  TotalDetailVC.swift
//  WeekChallenge
//
//  Created by shoh on 2022/04/01.
//

import UIKit

class TotalDetailVC: UIViewController {

    var documnetID: String?
    var userTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


class TotalDetailCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var userTitle: UILabel!
    @IBOutlet weak var userText: UILabel!
    
    func update(info: TotalDeatilModel, url: String) {
        userTitle.text = info.userTitle
        userText.text = info.userText
    }
    
    func heightOfCell(collection: UICollectionView) -> CGSize {
        return CGSize(width: collection.bounds.width - 100, height: collection.bounds.height - 200)
    }
}
