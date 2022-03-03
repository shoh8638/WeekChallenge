//
//  PlanCardCell.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/03.
//

import UIKit
import VerticalCardSwiper

class PlanCardCell: CardCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var titleBtn: UIButton!
    @IBOutlet weak var LSHView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    var documentID: String?
    var viewController: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func setView() {
        backView.layer.cornerRadius = 0.5
    }
    @IBAction func sendWrite(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "writeVC") as! WriteVC
        vc.documentID = self.documentID!
        viewController?.present(vc, animated: true, completion: nil)
    }
}
