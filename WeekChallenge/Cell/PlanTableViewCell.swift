//
//  PlanTableViewCell.swift
//  WeekChallenge
//
//  Created by shoh on 2022/02/14.
//

import UIKit

class PlanTableViewCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var detailBtn: UIButton!
    @IBOutlet weak var planView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
