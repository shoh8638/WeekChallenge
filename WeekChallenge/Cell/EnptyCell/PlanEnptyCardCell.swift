//
//  PlanEnptyCardCell.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/03.
//

import UIKit
import VerticalCardSwiper

class PlanEnptyCardCell: CardCell {
    var vc: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func enptyButton(_ sender: Any) {
        let createBtn = UIStoryboard(name: "Main", bundle:  nil).instantiateViewController(withIdentifier: "createVC") as! CreatePlanVC
        vc?.present(createBtn, animated: translatesAutoresizingMaskIntoConstraints, completion: nil)
    }
}
