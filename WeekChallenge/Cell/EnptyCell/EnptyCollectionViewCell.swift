//
//  EnptyCollectionViewCell.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/02.
//

import UIKit

class EnptyCollectionViewCell: UICollectionViewCell {
    
    var vc: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func createButton(_ sender: Any) {
        let createBtn = UIStoryboard(name: "Main", bundle:  nil).instantiateViewController(withIdentifier: "createVC") as! CreatePlanVC
        vc?.present(createBtn, animated: translatesAutoresizingMaskIntoConstraints, completion: nil)
    }
    
}
